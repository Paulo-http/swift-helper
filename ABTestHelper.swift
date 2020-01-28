//
//  ABTest.swift
//
//  Created by Paulo Henrique Leite on 14/01/20.
//

import Foundation
import Firebase


/*
    // Add in your AppDelegate
 
    private func configureFirebase() {
        // use this to get dev or prod environment according to bundle
        let file = Bundle.main.path(forResource: PATH, ofType: "plist") ?? ""
        if let options = FirebaseOptions(contentsOfFile: file) {
            FirebaseApp.configure(options: options)
        } else {
            FirebaseApp.configure()
        }
        
        FirebaseConfiguration.shared.setLoggerLevel(.min)
     
        ABTest.shared.fetch()
    }

*/

//  Remote variables

enum ABTestCase: String {
    case status
    
    internal func value() -> String {
        return ABTest.shared.remote?.configValue(forKey: self.rawValue).stringValue ?? ""
    }
}

class ABTest {

    static let shared = ABTest()

    internal var remote: RemoteConfig? = nil

    init() {
        self.remote = RemoteConfig.remoteConfig()
        self.remote?.setDefaults(fromPlist: "RemoteConfigDefaults")
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 60
        self.remote?.configSettings = settings
        self.device()
    }
    
    internal func fetch() {
        self.remote?.fetch(withExpirationDuration: TimeInterval(60), completionHandler: { (status, error) in
            if let error = error {
                Log.shared.show(error: error.localizedDescription)
            } else {
                self.activate()
            }
        })
    }
    
    private func activate() {
        self.remote?.activate(completionHandler: { (error) in
            if let error = error {
                Log.shared.show(error: error.localizedDescription)
                let value = ABTestCase.status.value()
                Log.shared.show(error: "RemoteConfig Status: \(value)")
            } else {
                let value = ABTestCase.status.value()
                Log.shared.show(info: "RemoteConfig Status: \(value)")
            }
        })
    }
    
    private func device() {
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                Log.shared.show(error: error.localizedDescription)
            } else {
                let token = result?.token ?? ""
                Log.shared.show(info: "Remote instance ID token: \(token)")
            }
        }
    }
    
}
