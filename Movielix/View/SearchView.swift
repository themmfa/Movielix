//
//  SearchView.swift
//  Movielix
//
//  Created by Fatih Erdoğan on 13.10.2022.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var searchViewModel: SearchViewModel

    var body: some View {
        VStack {
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

            Spacer()

            if !searchViewModel.searchedMovies.isEmpty {
                List(searchViewModel.searchedMovies, id: \.id) { movie in
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
        .padding()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchViewModel: SearchViewModel())
    }
}
