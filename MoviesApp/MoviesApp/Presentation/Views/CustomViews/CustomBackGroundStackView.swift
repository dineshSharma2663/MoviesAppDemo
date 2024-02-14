//
//  CustomBackGroundStackView.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 01/02/24.
//

import SwiftUI

// This class creates common background view used in the application using Z stack so that other UI components or views can be rendered on it.
struct CustomBackGroundStack<Content:View>:View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.black]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
                .ignoresSafeArea()
            content
        }
    }
}

