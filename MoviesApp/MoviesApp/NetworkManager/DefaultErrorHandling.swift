//
//  DefaultErrorHandling.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 15/01/24.
//

import Foundation
import MoviesUIKit

class DefaultErrorHandling {
    
    static func handleData(responseInfo: NetworkCallBackParams) {
        let errorMessage = Self.getErrorMessage(for: responseInfo.data)
        CommonAppAlertController.showAlert(message: errorMessage)
    }
    
    static func getErrorMessage(for data: Data?) -> String {
        var errorMessage: String = ""
        do {
            // make sure this JSON is in the format we expect
            if let responseData = data, let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] {
                errorMessage = json["message"] as? String ?? ""
            }
        } catch let error as NSError {
            errorMessage = error.localizedDescription
        }
        return errorMessage
    }
}
