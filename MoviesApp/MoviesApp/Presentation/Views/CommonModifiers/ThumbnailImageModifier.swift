//
//  ThumbnailImageModifier.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 02/02/24.
//

import SwiftUI

struct ThumbnailImageModifier: ViewModifier {
    
    let width: CGFloat = 125
    
    func body(content: Content) -> some View {
        content
            .frame(width: width, height: width*34/25)
            .clipped()
            .accessibilityIdentifier("Thumbnail Image")
            .background(Color(UIColor.lightGray.withAlphaComponent(0.3)))
    }
}
