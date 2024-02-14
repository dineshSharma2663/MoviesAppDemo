//
//  LoginView.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 31/01/24.
//

import SwiftUI

// This class is used in designing of Login screen.
struct LoginView: View {
    
    @ObservedObject var viewModel = LoginViewModel()

    @State private var showAlert: Bool = false
    @State private var shouldNavigate: Bool = false
    @State private var validationSuccess = false
    
    init() {
        // Setting large font title forground color here
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            CustomBackGroundStack {
                VStack {
                    TextField(LoginStrings.userNamePlaceholderText, text:  $viewModel.username)
                        .modifier(TextfieldModifier())
                        .accessibilityIdentifier(LoginConstants.AccessibilityIdentifiers.loginUserNameInput)
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                    
                    SecureField(LoginStrings.passwordPlaceholderText, text:  $viewModel.password)
                        .modifier(TextfieldModifier())
                        .accessibilityIdentifier(LoginConstants.AccessibilityIdentifiers.loginPasswordInput)
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                    
                    Button(LoginStrings.loginText) {
                        if viewModel.shouldShowValidationErrorAlert() {
                            showAlert = true
                        } else {
                            showAlert = false
                            shouldNavigate = true
                        }
                    }.buttonStyle(CommonAppButton())
                    .accessibilityIdentifier(LoginConstants.AccessibilityIdentifiers.loginButton)
                    Spacer()
                }
                .padding()
                .background(
                    NavigationLink(destination: MovieListView(viewModel: GetMoviesViewModel(repository: FetchMoviesRepository.makeRepository())), isActive: $shouldNavigate) {
                        EmptyView()
                    }
                    .hidden()
                )                
            }
            .navigationTitle(LoginStrings.loginText)
            .navigationBarTitleDisplayMode(.automatic)
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text(viewModel.getValidationAlertMessage() ?? ""))
            })
        }
        
    }
    
}


#Preview {
    LoginView()
}

