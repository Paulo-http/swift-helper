//
//  Log.swift
//
//  Created by Paulo Henrique Leite on 22/12/2017.
//

import UIKit

class Log {

    static let shared = Log()
    
    internal var debug = [String]()
    
    internal func show(info: Any) {
        print("💚 \(info)")
        self.debug.append("💚 \(info)")
    }

    internal func show(error: Any) {
        print("❤️ \(error)")
        self.debug.append("❤️ \(error)")
    }

    internal func show(event: Any) {
        print("💙 \(event)")
        self.debug.append("💙 \(event)")
    }
    
}
