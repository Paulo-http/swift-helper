//
//  Helper.swift
//
//  Created by Paulo Henrique Leite on 19/12/18.
//  Copyright © 2018 Paulo Henrique Leite. All rights reserved.
//

import Foundation

class Helper {
    
    static let shared = Helper()
    
    init() {}
    
    internal func generateCPF() -> String {
        var values: [Int] =  (1...9).map { _ in
            Int.random(in: 0...9)
        }

        let first = self.digit(values: values)
        values.append(first)
        
        let second = self.digit(values: values)
        values.append(second)
        
        let cpf = values.map { String($0) }.joined()
        
        return cpf
    }

    private func digit(values: [Int]) -> Int {
        var weight = values.count + 1
        
        let values: [Int] = values.map {
            let value = $0 * weight
            weight -= 1
            return value
        }
        
        let value = values.reduce(0, +) % 11
        
        return (value < 2) ? 0 : 11 - value
    }

}
