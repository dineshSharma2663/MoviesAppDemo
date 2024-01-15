//
//  MockNetworkHandler.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 15/01/24.
//

import Foundation

class MockNetworkHandler: NetworkHandlerProtocol {
    
    /// This function returns the mock api response after reading from the already provided json file
    /// - Parameters:
    ///   - service: network request
    ///   - completionHandler: response callback
    func initiateAPIRequest(service: NetworkService, completionHandler: @escaping APIResponse) {
        var jsonFileName: String = ""
        if service is FetchMoviesAPI {
            jsonFileName = "MockMovies"
        }
        guard let decodingDataModel = service.decodingType, !jsonFileName.isEmpty else {
            print("Please handle mocking for \(service.baseURL) first.")
            return
        }
        getMockResponse(decodingType: decodingDataModel, mockJsonFileName: jsonFileName, completionHandler: completionHandler)
    }
    
    private func getMockResponse(decodingType: Decodable.Type, mockJsonFileName: String, completionHandler: @escaping APIResponse) {
        if let path = Bundle.main.path(forResource: mockJsonFileName, ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let movieList = try JSONDecoder().decode(decodingType, from: data)
                completionHandler(movieList, nil)
              } catch let error {
                   // handle error
                  completionHandler(nil, error)
              }
        } else {
            completionHandler(nil, NSError(domain: "AppTest", code: 0, userInfo: [NSLocalizedDescriptionKey: "JSON File \(mockJsonFileName) not found"]))
        }
    }
}
