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
        let passField = app.textFields["loginPasswordInput"]
        let loginButton = app.buttons["loginButton"]
        var navBar = app.navigationBars[LoginStrings.loginText]
        // load movie controller
        // Successful login & navigation check to movies list screen
        loginField.tap()
        loginField.clearAndEnterText(text: "abc@gmail.com")
        passField.tap()
        passField.typeText("1234567")
        app.keyboards.buttons["Return"].tap()
        loginButton.tap()
        
        // Validate movies nav bar & its button
        navBar = app.navigationBars[MovieStrings.moviesText]
        XCTAssertTrue(navBar.exists)
        XCTAssertTrue(navBar.buttons["rightBarButton"].exists)
        
        // validating TableView Exists
        let table = app.tables[MoviesConstants.AccessibilityIdentifiers.moviesTableView]
        XCTAssertTrue(table.exists)
        
        // Validate Number of Rows / Cells
        let cells = table.cells
        XCTAssertTrue(cells.count == 100)
        
        // Validating First Cell & its content
        let firstCell = table.cells["MovieTableCell\(0)"]
        let movieName = firstCell.staticTexts["movieNameLabel_0"].label
        let movieSummary = firstCell.staticTexts["movieSummaryLabel_0"].label
        let rating = firstCell.staticTexts["ratingLabel_0"].label
        let releaseYear = firstCell.staticTexts["releaseDateLabel_0"].label
        XCTAssertTrue(firstCell.exists)
        XCTAssertEqual(movieName, "The Shawshank Redemption")
        XCTAssertEqual(movieSummary, "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.")
        XCTAssertEqual(rating, "9.3")
        XCTAssertEqual(releaseYear, "1994")
    }
}
