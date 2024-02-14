//
//  LoginViewModel.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 12/01/24.
//

import MoviesUIKit
//import SwiftUI
import Combine
import Foundation

// This LoginViewModel class handle the validation of username & password inputs. Then after shows alert if the validation fails for any scenarios.

final class LoginViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""

    func shouldShowValidationErrorAlert() -> Bool {
        return !(username.isValidEmail()) || !(password.isValidPassword())
    }
    
    func getValidationAlertMessage() -> String? {
        if !(username.isValidEmail()) {
            return LoginStrings.invalidEmailAlertMessage
        } else if !(password.isValidPassword()) {
            return LoginStrings.invalidPasswordAlertMessage
        } else {
            return nil
        }
    }
    
}

