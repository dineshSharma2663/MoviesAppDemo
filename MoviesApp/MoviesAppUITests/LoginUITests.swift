//
//  LoginUITests.swift
//  MoviesAppUITests
//
//  Created by Dinesh Kumar on 14/01/24.
//


import XCTest
@testable import MoviesApp

final class LoginUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("MockNetworking")
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app.terminate()
        app = nil
        try super.tearDownWithError()
    }
    
    func testLoginControllerFlow() {
        var navBar = app.navigationBars[LoginStrings.loginText]
        XCTAssertTrue(navBar.menuButtons.count == 0)
        XCTAssertTrue(navBar.exists)
        
        // Check for Textfields, Button exists or not
        let loginField = app.textFields["loginUserNameInput"]
        let passField = app.textFields["loginPasswordInput"]
        let loginButton = app.buttons["loginButton"]
        XCTAssertTrue(loginField.exists)
        XCTAssertTrue(passField.exists)
        XCTAssertTrue(loginButton.exists)
        
        // When Invalid Email inputs
        loginField.tap()
        loginField.typeText("abc")
        app.keyboards.buttons["Return"].tap()
        loginButton.tap()
        
        var alert = app.alerts.firstMatch
        XCTAssertTrue(alert.exists)
        var alertMessage = alert.staticTexts.firstMatch.label
        var alertTitle = alert.label
        XCTAssertTrue(alert.buttons["Ok"].exists)
        XCTAssertTrue(alertTitle.isEmpty)
        XCTAssertTrue(alertMessage == LoginStrings.invalidEmailAlertMessage)
        alert.buttons["Ok"].tap()
        
        // When invalid password entries
        loginField.tap()
        loginField.clearAndEnterText(text: "abc@gmail.com")
        passField.tap()
        passField.typeText("12345")
        app.keyboards.buttons["Return"].tap()
        loginButton.tap()
        
        // then show invalid password alert
        alert = app.alerts.firstMatch
        XCTAssertTrue(alert.exists)
        alertMessage = alert.staticTexts.firstMatch.label
        alertTitle = alert.label
        XCTAssertTrue(alert.buttons["Ok"].exists)
        XCTAssertTrue(alertTitle.isEmpty)
        XCTAssertTrue(alertMessage == LoginStrings.invalidPasswordAlertMessage)
        alert.buttons["Ok"].tap()
        
        // Successful login & navigation check to movies list screen
        loginField.tap()
        loginField.clearAndEnterText(text: "abc@gmail.com")
        passField.tap()
        passField.typeText("1234567")
        app.keyboards.buttons["Return"].tap()
        loginButton.tap()
        
        navBar = app.navigationBars[MovieStrings.moviesText]
        XCTAssertTrue(navBar.exists)
        XCTAssertTrue(navBar.menuButtons.count == 0)
    }
}
