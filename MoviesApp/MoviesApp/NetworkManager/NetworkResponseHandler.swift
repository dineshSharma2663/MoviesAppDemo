//
//  NetworkResponseHandler.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 25/01/24.
//

import Foundation

// This class is handling the server response for a request made by Network handler
class NetworkResponseHandler {
    
    /// Handling the api response
    /// - Parameters:
    ///   - service: Service request object
    ///   - responseInfo: response callbacl from URLsession
    ///   - completionHandler: completion
    static func handleResponse(service: NetworkService, responseInfo: NetworkCallBackParams, completionHandler: @escaping APIResponse) {
        guard let response = responseInfo.response as? HTTPURLResponse,
              200 ... 299 ~= response.statusCode else {
            DispatchQueue.main.async {
                if service.defaultErrorHandling {
                    DefaultErrorHandling.handleData(responseInfo: (data: responseInfo.data, response: responseInfo.response, error: responseInfo.error))
                }  
                let errorMessage = DefaultErrorHandling.getErrorMessage(for: responseInfo.data)
                completionHandler(.failure(NetworkClientError.setUpError(with: errorMessage)))
            }
            return
        }
        
        guard let data = responseInfo.data, responseInfo.error == nil else {
            DispatchQueue.main.async {
                completionHandler(.failure(NetworkClientError.invalidData.errorDetails))
            }
            return
        }
        DispatchQueue.main.async {
            var finalResponse: Any?
            if let decodingTypeIf = service.decodingType {
                finalResponse = CommonResponseParser.parseResonseData(decodingType: decodingTypeIf, data: data)
                completionHandler(.success(finalResponse))
            } else {
                completionHandler(.success(data))
            }
        }
    }
}
