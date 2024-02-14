//
//  NetworkService.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 15/01/24.
//

import Foundation

typealias NetworkCallBackParams = (data: Data?, response: URLResponse?, error: Error?)

enum ServiceType: String {
    case fetchMovies = "FetchMovies"
    case getMovieDetails = "GetMovieDetails"
}

protocol NetworkService {
    var path: String { get }
    var baseURL: String { get }
    var url: URL? { get }
    var method: HTTPMethods { get }
    var body: Encodable? { get }
    var headers: [String: String]? { get }
    var defaultErrorHandling: Bool { get }
    var decodingType: Decodable.Type? { get }
    var serviceType: ServiceType { get }
}
