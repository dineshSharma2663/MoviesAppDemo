//
//  MoviesListViewModelTests.swift
//  MoviesAppTests
//
//  Created by Dinesh Kumar on 15/01/24.
//

import XCTest
@testable import MoviesApp
import Combine

final class MoviesListViewModelTests: XCTestCase {

    var viewModel: GetMoviesViewModel!
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
       _ = APIManager.sharedInstance(MockNetworkHandler())
       
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        APIManager.resetMock()
    }
    
    func testMoviesViewModel() {
        viewModel = GetMoviesViewModel(repository: FetchMoviesRepository.makeRepository())
        let apiExpectation = expectation(description: "fetchMovies")
        viewModel.$movieResult
            .dropFirst()
            .sink { returnedItems in
                apiExpectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchMovies()
                
        // Then
        wait(for: [apiExpectation], timeout: 5)
        if case .success(let movies) = viewModel.movieResult {
            print("movies count-->>\(movies.count)")
            XCTAssertGreaterThan(movies.count, 0)
           }
       }

    
    
    /*
    // view model tests
    func testGetMoviees() {
        let apiExpectation = expectation(description: "fetchMovies")
        viewModel = FetchMoviesViewModel(repository: FetchMoviesRepository.makeRepository(), onSuccess: {
            XCTAssertTrue(self.viewModel.getNumberOfRows() == 100)
            let firstMovieInfo = self.viewModel.getMovieData(for: IndexPath(row: 0, section: 0))
            XCTAssertEqual(firstMovieInfo.title ?? "", "The Shawshank Redemption")
            XCTAssertEqual(firstMovieInfo.year ?? "", "1994")
            XCTAssertEqual(firstMovieInfo.rating ?? "", "9.3")
            apiExpectation.fulfill()
        }, onfailure: { errorMessage in
            apiExpectation.fulfill()
        })
        viewModel.fetchMovies(.onViewAppear)
        wait(for: [apiExpectation], timeout: 2)
    }
     */

}
