//
//  MoviesAppTests.swift
//  MoviesAppTests
//
//  Created by Dinesh Kumar on 03/01/24.
//
import SnapshotTesting
import XCTest
import SwiftUI
@testable import MoviesApp
@testable import Kingfisher

final class MoviesListSnapTests: XCTestCase {
    
    let imageTestURL = "https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_QL75_UX380_CR0,1,380,562_.jpg"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
       _ = APIManager.sharedInstance(MockNetworkHandler())
        let myImageCache = ImageCache(name: "imageCache")
        myImageCache.store(UIImage(named: "star")!, forKey: imageTestURL)
        KingfisherManager.shared.defaultOptions = [.onlyFromCache, .targetCache(myImageCache)]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        APIManager.resetMock()
        KingfisherManager.shared.defaultOptions = []
    }
    
    func testMovieItemView() {
        // Given
        let movieDataModel = MovieDisplayableModel(title: "Avengers", description: "One of Marvels Production movies", rating: "9", year: "2007", imageURLString: imageTestURL, accessibilityDetails: MovieCellAccessibilityInfo(ratingLabelAccessValue: "", releaseDateLabelAccessValue: "", movieNameLabelAccessibilityIdentifier: "", movieSummaryLabelAccessibilityIdentifier: "", ratingLabelAccessibilityIdentifier: "", releaseDateLabelAccessibilityIdentifier: "", movieThumbnailImageAccessibilityIdentifier: ""))
        
        // When
        let movieItemView = MovieItemView(movieInfo: movieDataModel)
        let hostController = UIHostingController(rootView: movieItemView)
        hostController.view.frame = UIScreen.main.bounds
        let hostControllerView: UIView = hostController.view
        
        // Then
        assertSnapshot(
            matching: hostControllerView,
            as: .image,
            named: "MovieItemView",
            testName: "MovieItemView"
        )
    }
    
    func testMovieListView() {
        // Given
        let getMoviesviewModel = GetMoviesViewModel(repository: FetchMoviesRepository.makeRepository())
        
        // When
        let movieListView = MovieListView(viewModel: getMoviesviewModel)
        let hostController = UIHostingController(rootView: movieListView)
        hostController.view.frame = UIScreen.main.bounds
        let hostControllerView: UIView = hostController.view
        
        // Then
            assertSnapshot(
                matching: hostControllerView,
                as: .image,
                named: "MovieListView",
                testName: "MovieListView"
            )
        
    }
        

}
