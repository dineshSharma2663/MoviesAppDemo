//
//  LoginStrings.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 14/01/24.
//

import Foundation

public struct LoginStrings {
    
    private static let fileName = "LoginStrings"
    
    public static var userNamePlaceholderText: String {
        return Localiser.localised(key: "userNamePlaceholderText", fileName: fileName)
    }
    
    public static var passwordPlaceholderText: String {
        return Localiser.localised(key: "passwordPlaceholderText", fileName: fileName)
    }
    
    public static var loginText: String {
        return Localiser.localised(key: "loginText", fileName: fileName)
    }
    
    public static var invalidEmailAlertMessage: String {
        return Localiser.localised(key: "invalidEmailAlertMessage", fileName: fileName)
    }
    
    public static var invalidPasswordAlertMessage: String {
        return Localiser.localised(key: "invalidPasswordAlertMessage", fileName: fileName)
    }
}
