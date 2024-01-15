//
//  MoviesListViewModelTests.swift
//  MoviesAppTests
//
//  Created by Dinesh Kumar on 15/01/24.
//

import XCTest
@testable import MoviesApp

final class MoviesListViewModelTests: XCTestCase {

    let viewModel = FetchMoviesViewModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
       _ = APIManager.sharedInstance(MockNetworkHandler())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        APIManager.resetMock()
    }
    
    // view model tests
    func testGetMoviees() {
        let apiExpectation = expectation(description: "fetchMovies")
        viewModel.fetchMovies { error in
            XCTAssertNil(error)
            XCTAssertTrue(self.viewModel.getNumberOfRows() == 100)
            let firstMovieInfo = self.viewModel.getMovieData(for: IndexPath(row: 0, section: 0))
            XCTAssertEqual(firstMovieInfo.title ?? "", "The Shawshank Redemption")
            XCTAssertEqual(firstMovieInfo.year ?? 0, 1994)
            XCTAssertEqual(firstMovieInfo.rank ?? 0, 1)
            XCTAssertEqual(firstMovieInfo.rating ?? "", "9.3")
            apiExpectation.fulfill()
        }
        wait(for: [apiExpectation], timeout: 2)
    }

}
