//
//  MovieItemView.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 30/01/24.
//

import SwiftUI
import Kingfisher

struct MovieItemView: View {
    
    @State var movieInfo: MovieDisplayableProtocol
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            KFImage(URL(string: movieInfo.imageURLString))
                .resizable()
                .modifier(ThumbnailImageModifier())
            
            VStack(alignment: .leading, spacing: 10) {
                Text(movieInfo.title ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                    .accessibilityIdentifier(movieInfo.accessibilityDetails.movieNameLabelAccessibilityIdentifier)
                Text(movieInfo.description ?? "")
                    .accessibilityIdentifier(movieInfo.accessibilityDetails.movieSummaryLabelAccessibilityIdentifier)
                    .font(.subheadline)
                    .foregroundColor(Color(UIColor.darkGray))
                Text(movieInfo.year ?? "")
                    .font(.caption)
                    .foregroundColor(Color(UIColor.lightGray))
                    .accessibilityValue(movieInfo.accessibilityDetails.ratingLabelAccessValue)
                    .accessibilityIdentifier(movieInfo.accessibilityDetails.releaseDateLabelAccessibilityIdentifier)
                HStack(spacing: 0){
                    Image("imdb")
                        .resizable()
                        .background(Color.clear)
                        .frame(width: 48, height: 35)
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                        .background(Color.clear)
                        .padding(0)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    Text(movieInfo.rating ?? "")
                        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 4))
                        .font(.caption)
                        .foregroundColor(Color(UIColor.darkGray))
                        .accessibilityValue(movieInfo.accessibilityDetails.ratingLabelAccessValue)
                        .accessibilityIdentifier(movieInfo.accessibilityDetails.ratingLabelAccessibilityIdentifier)
                    Image("star")
                        .resizable()
                        .background(Color.clear)
                        .frame(width: 22, height: 22)
                        .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                        .background(Color.clear)
                        .padding(0)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    Spacer()
                }
                .padding(EdgeInsets(top: -6, leading: 0, bottom: 0, trailing: 0))
                
            }
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            .frame(maxWidth: .infinity,
                   alignment: .topLeading)
        }
        .modifier(MovieItemViewModifier())
        
    }
}

#Preview {
    MovieItemView(movieInfo: MovieDisplayableModel(title: "Avengers", description: "Marvels", rating: "9", year: "1994", imageURLString: "", accessibilityDetails: MovieCellAccessibilityInfo(ratingLabelAccessValue: "", releaseDateLabelAccessValue: "", movieNameLabelAccessibilityIdentifier: "", movieSummaryLabelAccessibilityIdentifier: "", ratingLabelAccessibilityIdentifier: "", releaseDateLabelAccessibilityIdentifier: "", movieThumbnailImageAccessibilityIdentifier: "")))
}
