//
//  MovieStrings.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 14/01/24.
//

import Foundation

public struct MovieStrings {
    
    private static let fileName = "MovieStrings"
    
    public static var moviesText: String {
        return Localiser.localised(key: "moviesText", fileName: fileName)
    }
    
    public static var imdbRating: String {
        return Localiser.localised(key: "imdbRating", fileName: fileName)
    }
    
    public static var releaseYear: String {
        return Localiser.localised(key: "releaseYear", fileName: fileName)
    }
    
}
