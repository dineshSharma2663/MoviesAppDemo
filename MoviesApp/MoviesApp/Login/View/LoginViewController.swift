//
//  LoginViewController.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 10/01/24.
//

import MoviesUIKit
import UIKit
import Foundation

final class LoginViewController: CommonAppViewController {
    
    @IBOutlet private weak var usernameTextfield: CommonAppTextfield! {
        didSet {
            usernameTextfield.delegate = self
            usernameTextfield.backgroundColor = .tertiarySystemBackground
            usernameTextfield.style = .headline
            usernameTextfield.placeholder = LoginStrings.userNamePlaceholderText
            usernameTextfield.accessibilityIdentifier = LoginConstants.AccessibilityIdentifiers.loginUserNameInput
        }
    }
    
    @IBOutlet private weak var passwordTextfield: CommonAppTextfield! {
        didSet {
            passwordTextfield.delegate = self
            passwordTextfield.backgroundColor = .tertiarySystemBackground
            passwordTextfield.style =  .headline
            passwordTextfield.placeholder = LoginStrings.passwordPlaceholderText
            passwordTextfield.accessibilityIdentifier = LoginConstants.AccessibilityIdentifiers.loginPasswordInput
        }
    }
    
    @IBOutlet private weak var loginButton: CommonAppButton! {
        didSet {
            loginButton.backgroundColor = .tertiarySystemBackground
            loginButton.style = .title1
            loginButton.buttonLayoutType = CommonAppButtonType.roundedStandard
            loginButton.setTitle(LoginStrings.loginText, for: .normal)
            loginButton.accessibilityIdentifier = LoginConstants.AccessibilityIdentifiers.loginButton
        }
    }
    
    private var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LoginStrings.loginText
        self.view.backgroundColor = .secondarySystemBackground
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction private func loginButtonAction(_ sender: CommonAppButton) {
        loginViewModel.handleLogin(userName: usernameTextfield.text, password: passwordTextfield.text) { [weak self] inputValidationDone in
            guard let weakSelf = self else { return }
            if inputValidationDone {
                // Navigate to Movies List screen
                if let moviesController = weakSelf.storyboard?.instantiateViewController(withIdentifier: MoviesListViewController.classNameValue()) as? MoviesListViewController {
                    weakSelf.navigationController?.viewControllers = [moviesController]
                }
            }
        }
    }

}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
