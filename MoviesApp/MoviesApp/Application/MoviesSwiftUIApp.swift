//
//  MoviesApp.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 30/01/24.
//

import SwiftUI

@main
struct MoviesApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
