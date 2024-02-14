//
//  MovieListView.swift
//  MoviesApp
//
//  Created by Dinesh Kumar on 31/01/24.
//

import SwiftUI

struct MovieItemRowModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
    }
}

struct MovieListView: View {
    
    @StateObject var viewModel: GetMoviesViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        CustomBackGroundStack {
            if viewModel.movieResult == nil {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2.0, anchor: .center)
            } else {
                VStack {
                    switch viewModel.movieResult {
                    case .success(let movies):
                        // Show Movies
                        List {
                            ForEach(Array(zip(movies.indices, movies)), id: \.0) { index, movieData in
                                MovieItemView(movieInfo: movieData)
                                    .modifier(MovieItemRowModifier())
                            }
                        }
                        .accessibilityIdentifier(MoviesConstants.AccessibilityIdentifiers.moviesTableView)
                        .listStyle(.plain)
                    case .failure(let error):
                        // Show Error View
                        VStack {
                            Spacer()
                            Text(error.localizedDescription)
                                .font(.title)
                                .foregroundColor(Color.white)
                                .background(Color.clear)
                                .multilineTextAlignment(.leading)
                            Button {
                                fetchMovies()
                            } label: {
                                Text("Retry")
                                    .padding()
                                    .foregroundColor(Color.blue)
                                    .frame(width: 100, height: 45)
                                    .background(Color.white)
                                    .cornerRadius(8)
                            }.background(Color.clear)
                            Spacer()
                        }
                    case .none:
                        EmptyView()
                    }
                }.navigationBarTitle(MovieStrings.moviesText)
                    .navigationBarBackButtonHidden()
                    .navigationBarItems(leading: Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color.white)
                    }))
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .background(Color.clear)
            }
        }
        .onAppear(perform: {
            fetchMovies()
        })
    }
    
    private func fetchMovies() {
        viewModel.clearMovieResult()
        viewModel.fetchMovies()
    }
}

#Preview {
    MovieListView(viewModel: GetMoviesViewModel(repository: FetchMoviesRepository.makeRepository()))
}
