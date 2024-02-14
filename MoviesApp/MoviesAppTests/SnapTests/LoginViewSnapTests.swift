//
//  LoginViewControllerTests.swift
//  MoviesAppTests
//
//  Created by Dinesh Kumar on 11/01/24.
//

import SnapshotTesting
import XCTest
import SwiftUI
@testable import MoviesApp

final class LoginViewControllerTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoginView() {
        // Given
        
        // When
        let loginView = LoginView()
        let hostController = UIHostingController(rootView: loginView)
        hostController.view.frame = UIScreen.main.bounds
        let hostControllerView: UIView = hostController.view
        
        // Then
        assertSnapshot(
            matching: hostControllerView,
            as: .image,
            named: "LoginView",
            testName: "LoginView"
        )
        
    }

}
