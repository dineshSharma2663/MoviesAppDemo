//
//  NetworkManager.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 15/01/24.
//

import Foundation

class NetworkHandler: NetworkHandlerProtocol {
    
    /// Function to make server request  with provided service details
    /// - Parameters:
    ///   - service: input service request
    ///   - completionHandler: completion handler for the service request made
    func initiateAPIRequest(service: NetworkService, completionHandler: @escaping APIResponse) {
        guard let url = service.url else {
            completionHandler(.failure(NetworkClientError.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = service.method.rawValue
        if let parameters = service.body {
            request.httpBody = try? JSONEncoder().encode(parameters)
        }
        request.allHTTPHeaderFields = service.headers
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkResponseHandler.handleResponse(service: service, responseInfo: (data: data, response: response, error: error), completionHandler: completionHandler)
            
        }
        session.resume()
    }

}
