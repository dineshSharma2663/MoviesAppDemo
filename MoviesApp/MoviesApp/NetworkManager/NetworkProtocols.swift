//
//  NetworkProtocols.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 15/01/24.
//

import Foundation

protocol NetworkHandlerProtocol {
    func initiateAPIRequest(service: NetworkService, completionHandler: @escaping APIResponse)
}
