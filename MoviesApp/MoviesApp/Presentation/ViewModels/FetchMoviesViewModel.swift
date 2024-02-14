//
//  FetchMoviesViewModel.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 04/01/24.
//

import Foundation


final class GetMoviesViewModel: ObservableObject {
    private let repository: FetchMoviesRepositoryProtocol
    @Published private(set) var movieResult: Swift.Result<[MovieDisplayableProtocol], Error>?
    
    init(repository: FetchMoviesRepositoryProtocol) {
        self.repository = repository
    }
    
    func clearMovieResult() {
        movieResult = nil
    }
    
    func fetchMovies() {
        repository.fetchMovies { [weak self] result in
            guard let weakSelf = self else { return }
            switch result {
            case .success(let moviesList):
                weakSelf.movieResult = .success(moviesList)
            case .failure(let error):
                weakSelf.movieResult = .failure(error)
            }
        }
    }
}
