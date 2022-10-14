//
//  SearchView.swift
//  Movielix
//
//  Created by Fatih Erdoğan on 13.10.2022.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var searchViewModel: SearchViewModel
    @ObservedObject var movieViewModel: MoviesViewModel

    var body: some View {
        NavigationView {
            VStack {
                List(searchViewModel.searchedMovies, id: \.id) { movie in
                    SearchedMoviesListView(movie: movie, movieViewModel: movieViewModel)
                }
                .searchable(text: $searchViewModel.query)
            }
            .padding()
        }
    }
}

struct SearchedMoviesListView: View {
    var movie: Movie
    @ObservedObject var movieViewModel: MoviesViewModel
    var body: some View {
        NavigationLink(destination: MovieDetail(movieViewModel: movieViewModel, movie: movie)) {
            HStack {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 75)

                } placeholder: {
                    ProgressView()
                }
                Text(movie.title)
            }
        }
    }
}
