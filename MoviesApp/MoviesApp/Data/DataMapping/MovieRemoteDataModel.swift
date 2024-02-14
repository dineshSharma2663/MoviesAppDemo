//
//  MoviesModel.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 14/01/24.
//

import Foundation

// MARK: - MovieDataModel
struct MovieDataModel: Codable, Identifiable {
    let rank: Int?
    let title, description: String?
    let image, bigImage: String?
    let genre: [String]?
    let thumbnail: String?
    let rating, id: String?
    let year: Int?
    let imdbid: String?
    let imdbLink: String?

    enum CodingKeys: String, CodingKey {
        case rank, title, description, image
        case bigImage = "big_image"
        case genre, thumbnail, rating, id, year, imdbid
        case imdbLink = "imdb_link"
    }
}
