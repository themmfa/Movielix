//
//  SearchViewModel.swift
//  Movielix
//
//  Created by Fatih Erdoğan on 13.10.2022.
//

import Foundation

@MainActor
class SearchViewModel: ObservableObject {
    @Published var searched: [SearchedMovies] = []
    @Published var searchedMovies: [Movie] = []
    @Published var query = ""

    func getSearchedMovies() async {
        var movies: [Movie] = []
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(query)&page=1") else { return }
        searched = await getSearchedMovieIds(url: url)

        if !searched.isEmpty {
            for movieId in searched {
                guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId.id)?api_key=\(apiKey)&language=en-US") else { return }
                if let movie = await getMovieFromId(url: url) {
                    movies.append(movie)
                }
            }
            searchedMovies = movies
        }
    }

    private func getMovieFromId(url: URL) async -> Movie? {
        let urlRequest = URLRequest(url: url,cachePolicy: .returnCacheDataElseLoad)

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Could not connect to server")
                return nil
            }
            let movie = try JSONDecoder().decode(Movie.self, from: data)
            return movie
        }
        catch {
            print(error)
            return nil
        }
    }

    private func getSearchedMovieIds(url: URL) async -> [SearchedMovies] {
        let urlRequest = URLRequest(url: url,cachePolicy: .returnCacheDataElseLoad)

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Could not connect to server")
                return []
            }
            let movies = try JSONDecoder().decode(Results.self, from: data)
            return movies.results
        }
        catch {
            print(error)
            return []
        }
    }
}
