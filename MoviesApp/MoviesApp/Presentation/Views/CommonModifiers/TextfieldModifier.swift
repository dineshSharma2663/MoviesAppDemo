//
//  TextfieldModifier.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 02/02/24.
//

import SwiftUI

struct TextfieldModifier: ViewModifier {
    
    private let cornerRadius: CGFloat = 10
    
    func body(content: Content) -> some View {
        content
            .padding()
            .font(.headline)
            .frame(maxWidth: .infinity)
            .foregroundColor(.black)
            .background(Color.white)
            .cornerRadius(cornerRadius)
    }
}
