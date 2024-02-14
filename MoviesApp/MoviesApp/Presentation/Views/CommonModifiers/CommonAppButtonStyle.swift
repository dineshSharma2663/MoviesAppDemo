//
//  CommonAppButton.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 03/02/24.
//

import SwiftUI

struct CommonAppButton: ButtonStyle {
    private let cornerRaidus: CGFloat = 10
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .font(.headline)
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange, Color.blue]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
                .ignoresSafeArea()
            )
            .cornerRadius(cornerRaidus)
    }
}
