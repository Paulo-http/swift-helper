//
//  UITest.swift
//
//  Created by Paulo Henrique Leite on 17/12/18.
//

import UIKit
import Foundation
import XCTest

enum Direction {
    case left
    case right
    case up
    case down
}

enum Element {
    case button
    case backButton
    case textField
    case secureTextField
    case searchField
    case navigationBar
    case tabBar
    case table
    case alert
}

enum ElementId: String {
    case ok_button
    case cancel_button
}

class UITest {
    
    private let timeout: Double = 10
    private let app: XCUIApplication!
    static let shared = UITest()
    
    init() {
        self.app = XCUIApplication()
    }
    
    internal func start() {
        self.app.launchArguments += ["XCTest"]
        self.app.launch()
    }
    
    internal func tap(_ element: Element, id: ElementId, taps: Int = 1) {
        (1...taps).forEach { _ in
            switch element {
            case .button:
                let button = self.app.buttons[id.rawValue].firstMatch
                let exists = button.waitForExistence(timeout: self.timeout)
                XCTAssertTrue(exists)
                button.tap()
            case .backButton:
                let button = app.navigationBars.buttons.element(boundBy: 0)
                let exists = button.waitForExistence(timeout: self.timeout)
                XCTAssertTrue(exists)
                button.tap()
            case .textField:
                let textField = self.app.textFields[id.rawValue].firstMatch
                let exists = textField.waitForExistence(timeout: self.timeout)
                XCTAssertTrue(exists)
                textField.tap()
            case .secureTextField:
                let secureTextField = self.app.secureTextFields[id.rawValue].firstMatch
                let exists = secureTextField.waitForExistence(timeout: self.timeout)
                XCTAssertTrue(exists)
                secureTextField.tap()
            case .searchField:
                let searchField = self.app.searchFields[id.rawValue].firstMatch
                let exists = searchField.waitForExistence(timeout: self.timeout)
                XCTAssertTrue(exists)
                searchField.tap()
            case .navigationBar:
                let navigationBar = self.app.navigationBars.buttons[id.rawValue].firstMatch
                let exists = navigationBar.waitForExistence(timeout: self.timeout)
                XCTAssert(exists)
                navigationBar.tap()
            case .tabBar:
                let tabBar = self.app.tabBars.buttons[id.rawValue].firstMatch
                let exists = tabBar.waitForExistence(timeout: self.timeout)
                XCTAssert(exists)
                tabBar.tap()
            case .table:
                let table = self.app.tables.staticTexts[id.rawValue].firstMatch
                let exists = table.waitForExistence(timeout: self.timeout)
                XCTAssert(exists)
                table.tap()
            case .alert:
                let alert = self.app.alerts.buttons[id.rawValue].firstMatch
                let exists = alert.waitForExistence(timeout: self.timeout)
                XCTAssert(exists)
                alert.tap()
            }
        }
    }

    internal func type(text: String, element: Element, id: ElementId) {
        switch element {
        case .textField:
            let textField = self.app.textFields[id.rawValue].firstMatch
            let exists = textField.waitForExistence(timeout: self.timeout)
            XCTAssertTrue(exists)
            textField.clearText()
            textField.typeText(text)
        case .secureTextField:
            let secureTextField = self.app.secureTextFields[id.rawValue].firstMatch
            let exists = secureTextField.waitForExistence(timeout: self.timeout)
            XCTAssertTrue(exists)
            secureTextField.clearText()
            secureTextField.typeText(text)
        case .searchField:
            let searchField = self.app.searchFields[id.rawValue].firstMatch
            let exists = searchField.waitForExistence(timeout: self.timeout)
            XCTAssertTrue(exists)
            searchField.clearText()
            searchField.typeText(text)
        default:
            break
        }
    }
    
    internal func swipe(_ direction: Direction, swipes: Int = 1) {
        (1...swipes).forEach { _ in
            sleep(1)
            switch direction {
            case .left:
                self.app.swipeLeft()
            case .right:
                self.app.swipeRight()
            case .up:
                self.app.swipeUp()
            case .down:
                self.app.swipeDown()
            }
        }
    }

    internal func exists(_ element: Element, id: ElementId) -> Bool {
        switch element {
        case .button:
            let button = self.app.buttons[id.rawValue].firstMatch
            let exists = button.waitForExistence(timeout: self.timeout)
            return exists
        case .backButton:
            let button = app.navigationBars.buttons.element(boundBy: 0)
            let exists = button.waitForExistence(timeout: self.timeout)
            return exists
        case .textField:
            let textField = self.app.textFields[id.rawValue].firstMatch
            let exists = textField.waitForExistence(timeout: self.timeout)
            return exists
        case .secureTextField:
            let secureTextField = self.app.secureTextFields[id.rawValue].firstMatch
            let exists = secureTextField.waitForExistence(timeout: self.timeout)
            return exists
        case .searchField:
            let searchField = self.app.searchFields[id.rawValue].firstMatch
            let exists = searchField.waitForExistence(timeout: self.timeout)
            return exists
        case .navigationBar:
            let navigationBar = self.app.navigationBars.buttons[id.rawValue].firstMatch
            let exists = navigationBar.waitForExistence(timeout: self.timeout)
            return exists
        case .tabBar:
            let tabBar = self.app.tabBars.buttons[id.rawValue].firstMatch
            let exists = tabBar.waitForExistence(timeout: self.timeout)
            return exists
        case .table:
            let table = self.app.tables.staticTexts[id.rawValue].firstMatch
            let exists = table.waitForExistence(timeout: self.timeout)
            return exists
        case .alert:
            let alert = self.app.alerts.buttons[id.rawValue].firstMatch
            let exists = alert.waitForExistence(timeout: self.timeout)
            return exists
        }
    }

    internal func contains(_ value: Any) {
        switch value {
        case let text as String:
            let staticText = self.app.staticTexts[text]
            let exists = staticText.waitForExistence(timeout: self.timeout)
            XCTAssertTrue(exists)
        default:
            XCTAssertTrue(false)
        }
    }

    internal func notContains(_ value: Any) {
        switch value {
        case let text as String:
            let staticText = self.app.staticTexts[text]
            let exists = staticText.waitForExistence(timeout: self.timeout)
            XCTAssertTrue(!exists)
        default:
            XCTAssertTrue(false)
        }
    }

}
