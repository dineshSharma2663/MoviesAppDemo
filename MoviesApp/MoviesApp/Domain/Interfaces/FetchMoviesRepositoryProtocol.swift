//
//  FetchMoviesRepository.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 29/01/24.
//

import Foundation

protocol FetchMoviesRepositoryProtocol {
  typealias FetchMoviesResult = Result<[MovieDisplayableProtocol], Error>
  func fetchMovies(handler: @escaping (FetchMoviesResult) -> Void)
}
