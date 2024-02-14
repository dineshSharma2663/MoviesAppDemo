//
//  CommonResponseParser.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 15/01/24.
//

import Foundation

class CommonResponseParser {
    
    static func parseResonseData(decodingType: Decodable.Type, data: Data) -> Any? {
        do {
            let movieList = try JSONDecoder().decode(decodingType, from: data)
            return movieList
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
            return error
        }
    }
}
