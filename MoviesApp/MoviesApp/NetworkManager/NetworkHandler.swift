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
            completionHandler(nil, DataError.invalidURL)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = service.method.rawValue
        if let parameters = service.body {
            request.httpBody = try? JSONEncoder().encode(parameters)
        }
        request.allHTTPHeaderFields = service.headers
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                
                DispatchQueue.main.async {
                    DefaultErrorHandling.handleData(responseInfo: (data: data, response: response, error: error))
                    completionHandler(nil, DataError.invalidResponse)
                }
                return
            }
            
            guard let data, error == nil else {
                DispatchQueue.main.async {
                    completionHandler(nil, DataError.invalidData)
                }
                return
            }
            DispatchQueue.main.async {
                var finalResponse: Any?
                if let decodingTypeIf = service.decodingType {
                    finalResponse = CommonResponseHandler.parseResonseData(decodingType: decodingTypeIf, data: data)
                } else if let responseHandler = service.responseHandler {
                    finalResponse = responseHandler.parseResonseData(data: data)
                }
                completionHandler(finalResponse, nil)
            }
        }
        session.resume()
    }

}
