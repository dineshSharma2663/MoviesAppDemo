//
//  NavigationBarColorModifier.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 02/02/24.
//

import SwiftUI

struct NavigationBarColorModifier: ViewModifier {
    var color: UIColor
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                let coloredAppearance = UINavigationBarAppearance()
                coloredAppearance.configureWithDefaultBackground()
                coloredAppearance.titleTextAttributes = [.foregroundColor: color]
                coloredAppearance.largeTitleTextAttributes = [.foregroundColor: color]
                
                UINavigationBar.appearance().standardAppearance = coloredAppearance
                UINavigationBar.appearance().compactAppearance = coloredAppearance
                UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
            }
    }
}
