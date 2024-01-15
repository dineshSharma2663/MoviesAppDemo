//
//  Localiser.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 14/01/24.
//

import Foundation

class Localiser {
    
   static func localised(key: String, fileName: String) -> String {
        return NSLocalizedString(key, tableName: fileName, bundle: Bundle(for: Localiser.self), comment: "")
    }
}
