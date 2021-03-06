//
//  ReusableViewExtension.swift
//  ChefsClub
//
//  Created by Paulo Henrique Leite on 07/12/18.
//  Copyright © 2018 ChefsClub. All rights reserved.
//

import Foundation

protocol ReusableView: class {
    static var identifier: String { get }
}

extension ReusableView where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
}

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
