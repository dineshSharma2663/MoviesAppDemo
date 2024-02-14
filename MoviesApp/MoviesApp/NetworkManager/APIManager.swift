//
//  APIManager.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 04/01/24.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

typealias APIResponse = (Result<Any?, Error>) -> Void

enum NetworkClientError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
    case decoding(Error?)
    
    var errorDetails: NSError {
        var localisedMessage: String = ""
        switch self {
        case .invalidResponse:
            localisedMessage = "Response is invalid for this request."
        case .invalidURL:
            localisedMessage = "Request URL is invalid for this request."
        case .invalidData:
            localisedMessage = "Response Data is invalid for this request."
        default:
            localisedMessage  = "An error occurred. Please try after some time."
        }
        return NSError(domain: "AppTest", code: 0, userInfo: [NSLocalizedDescriptionKey: localisedMessage])
    }
    
    static func setUpError(with message: String) -> NSError {
        return NSError(domain: "AppTest", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
    }
}

final class APIManager {
    
    // Network handler instance for making api calls to he server
    private static var networkHandler: NetworkHandlerProtocol = NetworkHandler()
    // Mock Network handler instance for getting the mock data for unit test & other development flows
    private static var mockNetworkHandler: NetworkHandlerProtocol?
    
    /// Creating the singleton instance of NetworkHandlerProtocol
    /// - Parameter handlerInstance: provide the handler instance  for use // e.g for mocking
    /// - Returns: returns the instance of NetworkHandlerProtocol
    static func sharedInstance(_ handlerInstance: NetworkHandlerProtocol? = nil) -> NetworkHandlerProtocol {
        if let mockNetworking = handlerInstance {
            self.mockNetworkHandler = mockNetworking
            return mockNetworking
        }
        if let mockNetworking = APIManager.mockNetworkHandler {
            return mockNetworking
        } else if ProcessInfo.processInfo.arguments.contains("MockNetworking") {
            let mockNetworkInstance = MockNetworkHandler()
            mockNetworkHandler = mockNetworkInstance
            return mockNetworkInstance
        } else {
            return networkHandler
        }
    }

    // Resetting the mock network handlers
    static func resetMock() {
        self.mockNetworkHandler = nil
    }

}
