//
//  DefaultErrorHandling.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 15/01/24.
//

import Foundation
import MoviesUIKit

typealias DefaultErrorHandlingParams = (data: Data?, response: URLResponse?, error: Error?)


class DefaultErrorHandling {
    
    static func handleData(responseInfo :DefaultErrorHandlingParams) {
        if let dataInfo = responseInfo.data {
            do {
                // make sure this JSON is in the format we expect
                if let json = try JSONSerialization.jsonObject(with: dataInfo, options: []) as? [String: Any] {
                    CommonAppAlertController.showAlert(message: (json["message"] as? String) ?? "")
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
    }
}
