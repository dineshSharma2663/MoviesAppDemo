//
//  FetchMoviesRepository.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 29/01/24.
//

import Foundation

final internal class FetchMoviesRepository: FetchMoviesRepositoryProtocol {
    
    private let httpClient: NetworkHandlerProtocol
    private let api: FetchMoviesAPI
    
    internal init(httpClient: NetworkHandlerProtocol, api: FetchMoviesAPI) {
        self.httpClient = httpClient
        self.api = api
    }
    
    // MARK: - FetchMoviesRepository
    func fetchMovies(handler: @escaping (FetchMoviesResult) -> Void) {
        self.httpClient.initiateAPIRequest(service: FetchMoviesAPI()) { result in
            switch result {
            case .success(let data):
                if let moviesList = data as? [MovieDataModel] {
                    handler(.success(Self.getDisplayableMovies(moviesList: moviesList)))
                } else if let moviesData = data as? Data {
                    if let moviesList = Self.parse(type: [MovieDataModel].self, data: moviesData) {
                        handler(.success(Self.getDisplayableMovies(moviesList: moviesList)))
                    }
                }
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
    private static func getDisplayableMovies(moviesList: [MovieDataModel]) -> [MovieDisplayableProtocol] {
        var movieDisplayList = [MovieDisplayableProtocol]()
        for (index, movieInfo) in moviesList.enumerated() {
            let movieDisplayModel = movieInfo.getDisplayableModel(index: index)
            movieDisplayList.append(movieDisplayModel)
        }
        return movieDisplayList
    }
    
    private static func parse<T: Decodable>(type: T.Type, data: Data) -> T? {
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    static func makeRepository() -> FetchMoviesRepositoryProtocol {
        return FetchMoviesRepository(httpClient: APIManager.sharedInstance(), api: FetchMoviesAPI())
    }
}

fileprivate extension MovieDataModel {
    func getDisplayableModel(index: Int) -> MovieDisplayableProtocol {
        return MovieDisplayableModel(title: self.title, description: self.description, rating: self.rating, year: "\(self.year ?? 0)", imageURLString: self.image ?? "", accessibilityDetails: getAccessibilityDetails(index: index))
    }
    
    func getAccessibilityDetails(index: Int) -> MovieCellAccessibilityProtocol {
        let indexSuffix = "\(index)"
        let movieAccessInfo = MovieCellAccessibilityInfo(ratingLabelAccessValue: MovieStrings.imdbRating,
                                                         releaseDateLabelAccessValue: MovieStrings.releaseYear,
                                                         movieNameLabelAccessibilityIdentifier: MoviesConstants.AccessibilityIdentifiers.movieNameLabel + indexSuffix,
                                                         movieSummaryLabelAccessibilityIdentifier: MoviesConstants.AccessibilityIdentifiers.movieSummaryLabel + indexSuffix,
                                                         ratingLabelAccessibilityIdentifier: MoviesConstants.AccessibilityIdentifiers.ratingLabel + indexSuffix,
                                                         releaseDateLabelAccessibilityIdentifier: MoviesConstants.AccessibilityIdentifiers.releaseDateLabel + indexSuffix,
                                                         movieThumbnailImageAccessibilityIdentifier: MoviesConstants.AccessibilityIdentifiers.movieNameLabel + indexSuffix)
        return movieAccessInfo
    }
    
}

