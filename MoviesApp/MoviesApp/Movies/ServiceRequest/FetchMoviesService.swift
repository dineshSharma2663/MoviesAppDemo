//
//  FetchMoviesService.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 14/01/24.
//

import Foundation

struct FetchMoviesAPI: NetworkService {
    
    var responseHandler: ResponseHandlerProtocol?
    var decodingType: Decodable.Type?
    
    var path: String
    var baseURL: String
    var url: URL?
    var method: HTTPMethods
    var body: Encodable?
    var headers: [String : String]?
 
    init() {
        self.body = nil
        self.baseURL = "https://imdb-top-100-movies.p.rapidapi.com/"
        self.path = ""
        self.headers = [
            "X-RapidAPI-Key": "3af9a55220msh98cc5c5a42b5a23p1c400cjsnb24ff4cc0e87",
            "X-RapidAPI-Host": "imdb-top-100-movies.p.rapidapi.com"
        ]
        self.url = URL(string: "\(baseURL)\(path)")
        self.method = HTTPMethods.get
        self.decodingType = [MovieDataModel].self
    }
}
