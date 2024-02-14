//
//  MovieItemViewModifier.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 02/02/24.
//

import SwiftUI

struct MovieItemViewModifier: ViewModifier {
    
    private let cornerRadius: CGFloat = 10
    
    func body(content: Content) -> some View {
        content
            .background(Color.white)
            .cornerRadius(cornerRadius)
            .overlay( 
                // Applying rounded border here
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(.white, lineWidth: 1)
            )
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
    }
}
