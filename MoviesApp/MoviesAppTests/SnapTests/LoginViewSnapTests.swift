//
//  LoginViewControllerTests.swift
//  MoviesAppTests
//
//  Created by Dinesh Kumar on 11/01/24.
//

import SnapshotTesting
import XCTest
@testable import MoviesApp

final class LoginViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testMyViewControllerSnapShot() {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController")
        vc.loadViewIfNeeded()
        assertSnapshot(
            matching: vc,
            as: .image,
            named: "LoginViewController",
            testName: "LoginViewController"
        )
    }

}
