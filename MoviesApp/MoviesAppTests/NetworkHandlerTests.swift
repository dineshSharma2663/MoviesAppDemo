//
//  NetworkHandlerTests.swift
//  MoviesAppTests
//
//  Created by Dinesh Kumar on 25/01/24.
//

import XCTest
@testable import MoviesApp

final class NetworkHandlerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSuccessStatusCodeButNetworkErrorNetworkResponseHandler() {
        let apiExpectation = expectation(description: "NetworkResponseHandler")
        var apiService = FetchMoviesAPI()
//        apiService.defaultErrorHandling = false
//        XCTAssertEqual(apiService.defaultErrorHandling, false)
//        apiService.defaultErrorHandling = true
//        XCTAssertEqual(apiService.defaultErrorHandling, true)
        apiService.serviceType = ServiceType.getMovieDetails
        let networkError = NSError(domain: "AppTest", code: 0, userInfo: [NSLocalizedDescriptionKey: "JSON File not found"])
        if let demoURL = URL(string: "https://www.google.com/") {
            let urlResponse = HTTPURLResponse(url: demoURL, statusCode: 200, httpVersion: "", headerFields: nil)
            NetworkResponseHandler.handleResponse(service: apiService, responseInfo: (data: Data(), response: urlResponse, error: networkError), completionHandler: { result in
                switch result {
                case .success(let data):
                    XCTAssertNotNil(data)
                    XCTAssertEqual("Success", (data as? String ?? ""))
                case .failure(let error):
                    XCTAssertNotNil(error)
                    XCTAssertTrue(error.localizedDescription.count > 1)
                }
                apiExpectation.fulfill()
            })
        }
        wait(for: [apiExpectation], timeout: 2)
    }
    
    func testNetworkErrorStatusCodeNetworkResponseHandler() {
        let apiExpectation = expectation(description: "NetworkResponseHandler")
        var apiService = FetchMoviesAPI()
        apiService.serviceType = ServiceType.getMovieDetails
        let networkError = NSError(domain: "AppTest", code: 0, userInfo: [NSLocalizedDescriptionKey: "JSON File not found"])
        if let demoURL = URL(string: "https://www.google.com/") {
            var urlResponse = HTTPURLResponse(url: demoURL, statusCode: 400, httpVersion: "", headerFields: nil)
            NetworkResponseHandler.handleResponse(service: apiService, responseInfo: (data: Data(), response: urlResponse, error: networkError), completionHandler: { result in
                switch result {
                case .success(let data):
                    XCTAssertNotNil(data)
                    XCTAssertEqual("Success", (data as? String ?? ""))
                case .failure(let error):
                    XCTAssertNotNil(error)
                    XCTAssertTrue(error.localizedDescription.count > 1)
                }
                
                apiExpectation.fulfill()
            })
        }
        wait(for: [apiExpectation], timeout: 2)
    }
    
    func testSuccessResultNetworkResponseHandler() {
        var responseData: Data?
        do {
            let encoder = JSONEncoder()
            responseData = try encoder.encode("Success")
        } catch let error {
            XCTFail()
        }
        
        let apiExpectation = expectation(description: "NetworkResponseHandler")
        var apiService = FetchMoviesAPI()
        apiService.decodingType = String.self
        apiService.serviceType = ServiceType.getMovieDetails
        if let demoURL = URL(string: "https://www.google.com/") {
            var urlResponse = HTTPURLResponse(url: demoURL, statusCode: 200, httpVersion: "", headerFields: nil)
            NetworkResponseHandler.handleResponse(service: apiService, responseInfo: (data: responseData, response: urlResponse, error: nil), completionHandler: { result in
                switch result {
                case .success(let data):
                    XCTAssertNotNil(data)
                    XCTAssertEqual("Success", (data as? String ?? ""))
                case .failure(let error):
                    XCTAssertNotNil(error)
                }
                apiExpectation.fulfill()
            })
        }
        wait(for: [apiExpectation], timeout: 2)
    }
    
    func testInvalidService() {
        let apiExpectation = expectation(description: "InvalidService")
        var apiService = FetchMoviesAPI()
        apiService.serviceType = ServiceType.getMovieDetails
        let apiWorker = MockNetworkHandler()
        apiWorker.initiateAPIRequest(service: apiService) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            apiExpectation.fulfill()
        }
        wait(for: [apiExpectation], timeout: 2)
    }

}
