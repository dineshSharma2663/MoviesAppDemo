//
//  LoginViewModel.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 12/01/24.
//

import MoviesUIKit

// This LoginViewModel class handle the validation of username & password inputs. Then after shows alert if the validation fails for any scenarios.
final class LoginViewModel {
    
    func handleLogin(userName: String?, password: String?, completion: @escaping (Bool) -> Void) {
        if !(userName?.isValidEmail() ?? true) {
            CommonAppAlertController.showAlert(message: LoginStrings.invalidEmailAlertMessage)
        } else if !(password?.isValidPassword() ?? true) {
            CommonAppAlertController.showAlert(message: LoginStrings.invalidPasswordAlertMessage)
        } else {
            completion(true)
        }
    }
    
}
