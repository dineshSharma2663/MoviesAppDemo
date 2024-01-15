//
//  NetworkService.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 15/01/24.
//

import Foundation

protocol NetworkService {
    var path: String { get }
    var baseURL: String { get }
    var url: URL? { get }
    var method: HTTPMethods { get }
    var body: Encodable? { get }
    var headers: [String: String]? { get }
    var defaultErrorHandling: Bool? { get set }
    var responseHandler: ResponseHandlerProtocol? { get set }
    var decodingType: Decodable.Type? { get }
}

extension NetworkService {
    var responseHandler: ResponseHandlerProtocol? {
        get {
            nil
        } set {
            responseHandler =  newValue
        }
    }
    
    var defaultErrorHandling: Bool? {
        get {
            true
        } set {
            defaultErrorHandling =  newValue
        }
    }
}
