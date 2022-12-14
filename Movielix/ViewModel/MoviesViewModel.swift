//
//  MoviesViewModel.swift
//  Movielix
//
//  Created by Fatih Erdoğan on 12.10.2022.
//

import Foundation

@MainActor
class MoviesViewModel: ObservableObject {
    let baseUrl = "https://api.themoviedb.org/3/movie"
    @Published var topRated: [Movie] = []
    @Published var popular: [Movie] = []
    @Published var upcoming: [Movie] = []
    @Published var similar: [Movie] = []
    @Published var casts: [Cast] = []

    func getSimilarMovies(id: Int) async {
        guard let url = URL(string: "\(baseUrl)/\(id)/similar?api_key=\(apiKey)&language=en-US&page=1") else { return }
        similar = await getMovies(url: url)
    }

    func getCasts(id: Int) async {
        guard let url = URL(string: "\(baseUrl)/\(id)/credits?api_key=\(apiKey)&language=en-US&page=1") else { return }
        casts = await getCasts(url: url)
    }

    func getUpcomingMovies() async {
        guard let url = URL(string: "\(baseUrl)/upcoming?api_key=\(apiKey)&language=en-US&page=1") else { return }
        upcoming = await getMovies(url: url)
    }

    func getPopularMovies() async {
        guard let url = URL(string: "\(baseUrl)/popular?api_key=\(apiKey)&language=en-US&page=1") else { return }
        popular = await getMovies(url: url)
    }

    func getTopRatedMovies() async {
        guard let url = URL(string: "\(baseUrl)/top_rated?api_key=\(apiKey)&language=en-US&page=1") else { return }
        topRated = await getMovies(url: url)
    }

    private func getCasts(url: URL) async -> [Cast] {
        let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Could not connect to server")
                return []
            }
            let casts = try JSONDecoder().decode(Casts.self, from: data)
            return casts.cast
        }
        catch {
            print(error)
            return []
        }
    }

    private func getMovies(url: URL) async -> [Movie] {
        let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Could not connect to server")
                return []
            }
            let movies = try JSONDecoder().decode(NowPlaying.self, from: data)
            return movies.results
        }
        catch {
            print(error)
            return []
        }
    }
}
