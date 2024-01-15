//
//  MoviesAppTests.swift
//  MoviesAppTests
//
//  Created by Dinesh Kumar on 03/01/24.
//
import SnapshotTesting
import XCTest
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
    
    func testMyViewControllerSnapShot() {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: MoviesListViewController.self))
        vc.loadViewIfNeeded()
        
        assertSnapshot(
            matching: vc,
            as: .image,
            named: "MoviesListViewController",
            testName: "MoviesListViewController"
        )
    }

}
