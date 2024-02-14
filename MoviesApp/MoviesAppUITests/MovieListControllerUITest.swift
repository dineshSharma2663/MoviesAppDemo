//
//  MovieListControllerUITest.swift
//  MoviesAppUITests
//
//  Created by Dinesh Kumar on 05/01/24.
//

import XCTest
@testable import Kingfisher
@testable import MoviesApp

final class MovieListControllerUITest: XCTestCase {

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
    
    func testMoviesControllerView() {
        // Get Textfields, Button exists or not
        let loginField = app.textFields["loginUserNameInput"]
        let passField = app.secureTextFields["loginPasswordInput"]
        let loginButton = app.buttons["loginButton"]
        var navBar = app.navigationBars[MovieStrings.moviesText]
        // Successful login & navigation check to movies list screen
        loginField.tap()
        loginField.clearAndEnterText(text: "abc@gmail.com")
        passField.tap()
        passField.typeText("1234567")

        loginButton.tap()
        
        // Validate movies nav bar & its button
        navBar = app.navigationBars[MovieStrings.moviesText]
        XCTAssertTrue(navBar.exists)
        
        // validating TableView Exists
        let table = app.collectionViews[MoviesConstants.AccessibilityIdentifiers.moviesTableView]
        XCTAssertTrue(table.exists)
        
        // Validate Number of Rows / Cells
        
        // Validating First Cell & its content
        let firstCell = table.children(matching: .cell).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element
        
//        let firstCell = table.cells["MovieTableCell\(0)"]
        let movieName = table.staticTexts["movieNameLabel_0"].label
        let movieSummary = table.staticTexts["movieSummaryLabel_0"].label
        let rating = table.staticTexts["ratingLabel_0"].label
        let releaseYear = table.staticTexts["releaseDateLabel_0"].label
        XCTAssertTrue(firstCell.exists)
        XCTAssertEqual(movieName, "The Shawshank Redemption")
        XCTAssertEqual(movieSummary, "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.")
        XCTAssertEqual(rating, "9.3")
        XCTAssertEqual(releaseYear, "1994")
    }
}
