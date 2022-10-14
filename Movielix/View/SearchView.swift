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
        }
    }
}

struct SearchedMoviesListView: View {
    var movie: Movie
    @ObservedObject var movieViewModel: MoviesViewModel
    var body: some View {
        NavigationLink(destination: MovieDetail(movieViewModel: movieViewModel, movie: movie)) {
            HStack(spacing: 4) {
                AsyncImageLoader(movie: movie, height: 75, width: 50)
                VStack(alignment: .leading, spacing: 4) {
                    Text(movie.title)
                        .font(.title2)

                    Text(String(format: "%.1f", movie.vote_average))
                        .font(.subheadline)
                }
            }
        }
    }
}
