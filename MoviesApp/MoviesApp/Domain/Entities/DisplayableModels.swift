//
//  DisplayableModels.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 29/01/24.
//

import Foundation

protocol MovieCellAccessibilityProtocol {
    var ratingLabelAccessValue: String { get }
    var releaseDateLabelAccessValue: String { get }
    var movieNameLabelAccessibilityIdentifier: String { get }
    var movieSummaryLabelAccessibilityIdentifier: String { get }
    var ratingLabelAccessibilityIdentifier: String { get }
    var releaseDateLabelAccessibilityIdentifier: String { get }
    var movieThumbnailImageAccessibilityIdentifier: String { get }
}

struct MovieCellAccessibilityInfo: MovieCellAccessibilityProtocol {
    let ratingLabelAccessValue: String
    let releaseDateLabelAccessValue: String
    let movieNameLabelAccessibilityIdentifier: String
    let movieSummaryLabelAccessibilityIdentifier: String
    let ratingLabelAccessibilityIdentifier: String
    let releaseDateLabelAccessibilityIdentifier: String
    let movieThumbnailImageAccessibilityIdentifier: String
}

protocol MovieDisplayableProtocol {
    var title: String? { get }
    var description: String? { get }
    var rating: String? { get }
    var year: String? { get }
    var imageURLString: String { get }
    var accessibilityDetails: MovieCellAccessibilityProtocol { get }
}

// Displayable movie Data model
struct MovieDisplayableModel: MovieDisplayableProtocol {
    let title: String?
    let description: String?
    let rating: String?
    let year: String?
    let imageURLString: String
    let accessibilityDetails: MovieCellAccessibilityProtocol
}

