//
//  FetchMoviesService.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 14/01/24.
//

import Foundation

struct FetchMoviesAPI: NetworkService {
    var serviceType: ServiceType
    var decodingType: Decodable.Type?
    var path: String
    var baseURL: String
    var url: URL?
    var method: HTTPMethods
    var body: Encodable?
    var headers: [String : String]?
    var defaultErrorHandling: Bool
 
    init() {
        self.serviceType = ServiceType.fetchMovies
        self.body = nil
        self.baseURL = "https://imdb-top-100-movies.p.rapidapi.com/"
        self.path = ""
        self.headers = [
            "X-RapidAPI-Key": "46eb4e728emshbe3673f6fbc91b1p115c7bjsne445f7e356ee",
            "X-RapidAPI-Host": "imdb-top-100-movies.p.rapidapi.com"
        ]
        self.url = URL(string: "\(baseURL)\(path)")
        self.method = HTTPMethods.get
        self.decodingType = [MovieDataModel].self
        self.defaultErrorHandling = false
    }
}
