//
//  FetchMoviesViewModel.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 04/01/24.
//

import Foundation

class FetchMoviesViewModel {
    
    private var movieList = [MovieDataModel]()
    
    func getMovieData(for indexPath: IndexPath) -> MovieDataModel {
        return movieList[indexPath.row]
    }
    
    func getNumberOfRows() -> Int {
        return movieList.count
    }
    
    func fetchMovies(completion: @escaping (Error?)-> Void) {
        APIManager.sharedInstance().initiateAPIRequest(service: FetchMoviesAPI()) { (dataInfo, error) in
            if let movieArray = dataInfo as? [MovieDataModel] {
                self.movieList = movieArray
            }
            completion(error)
        }
    }
}
