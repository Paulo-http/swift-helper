//
//  Cookie.swift
//
//  Created by Paulo Henrique Leite on 08/08/2018.
//

import Foundation

class Cookie {
    
    static let shared = Cookie()
        
    /**
     Get a cookie by uuid of restaurant with nearest expiration.
     - Parameter uuid: The uuid of restaurant saved on cookie value.
     - Returns: The HTTPCookie with longest expiration that match with the uuid
     */
    internal func get(_ name: String) -> HTTPCookie? {
        let cookies = HTTPCookieStorage.shared.cookies?.filter { $0.name.contains(name) } ?? []
        let filtered = cookies.filter { $0.expiresDate ?? Date() > Date() }
        let sorted = filtered.sorted { $0.expiresDate ?? Date() < $1.expiresDate ?? Date() }
        return sorted.last
    }
    
    /**
     Get a cookie by uuid of restaurant with nearest expiration.
     - Parameter uuid: The uuid of restaurant saved on cookie value.
     - Returns: all HTTPCookie that match with the uuid
     */
    internal func getAll(_ name: String) -> [HTTPCookie]? {
        let cookies = HTTPCookieStorage.shared.cookies?.filter { $0.name.contains(name) } ?? []
        let sorted = cookies.sorted { $0.expiresDate ?? Date() < $1.expiresDate ?? Date() }
        return sorted
    }

    /**
     Set a cookie by name.
     - Parameter name: The cookie name.
     - Parameter values: A JSON to save on cookie.
     - Parameter expires: The date of expiration
     */
    internal func set(_ name: String, values: [String : Any], expires: Date) {
        let JSON = values.toJSONString() ?? ""
        let domain = Bundle.main.bundleIdentifier ?? ""
        
        let properties: [HTTPCookiePropertyKey : Any] = [.name : name,
                                                         .secure : true,
                                                         .value : JSON,
                                                         .path : "/",
                                                         .expires : expires,
                                                         .domain: domain]
        
        if let cookie = HTTPCookie(properties: properties) {
            HTTPCookieStorage.shared.setCookie(cookie)
        } else {
            Log.shared.show(error: "HTTPCookie \(name) - creation failed")
        }
    }

    /**
     Remove a cookie by name.
     - Parameter name: The cookie name.
     */
    internal func delete(_ name: String) {
        if let cookie = HTTPCookieStorage.shared.cookies?.first(where: { $0.name == name }) {
            HTTPCookieStorage.shared.deleteCookie(cookie)
        } else {
            Log.shared.show(error: "HTTPCookie \(name) - delete failed")
        }
    }

    /**
     Remove all cookies.
     */
    internal func deleteAll() {
        HTTPCookieStorage.shared.cookies?.forEach {
            HTTPCookieStorage.shared.deleteCookie($0)
        }
    }

}
