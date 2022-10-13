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
                SearchBar(searchViewModel: searchViewModel)
                Spacer()
                if !searchViewModel.searchedMovies.isEmpty {
                    List(searchViewModel.searchedMovies, id: \.id) { movie in
                        SearchedMoviesListView(movie: movie, movieViewModel: movieViewModel)
                    }
                }
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

struct SearchBar: View {
    @ObservedObject var searchViewModel: SearchViewModel

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .font(.title)
                .foregroundColor(.black)
            TextField("Search..", text: $searchViewModel.query)
                .font(.headline)
                .textInputAutocapitalization(.none)
                .autocorrectionDisabled()
        }
        .padding(10)
        .background(.gray)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
