//
//  Movies.swift
//  Movielix
//
//  Created by Fatih Erdoğan on 12.10.2022.
//

import SwiftUI

struct Movies: View {
    @State private var selectedTab: Tab = .film
    @StateObject var movieViewModel = MoviesViewModel()
    @StateObject var searchViewModel = SearchViewModel()

    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        ZStack {
            VStack {
                TabView(selection: $selectedTab) {
                    ForEach(Tab.allCases, id: \.rawValue) { _ in
                        if selectedTab.rawValue == "film" {
                            MoviesView(movieViewModel: movieViewModel)
                        }
                        if selectedTab.rawValue == "magnifyingglass" {
                            SearchView(searchViewModel: searchViewModel, movieViewModel: movieViewModel)
                                .onChange(of: searchViewModel.query) { newItem in
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                        searchViewModel.searchedMovies.removeAll()
                                        Task {
                                            if newItem == searchViewModel.query {
                                                if searchViewModel.query != "" {
                                                    await searchViewModel.getSearchedMovies()
                                                }
                                                else {
                                                    searchViewModel.searchedMovies.removeAll()
                                                }
                                            }
                                        }
                                    }
                                }
                            Spacer()
                        }
                    }
                }
            }
        }
        VStack {
            // Spacer()
            CustomTabBar(selectedTab: $selectedTab)
        }
    }
}

struct CustomTextModifier: ViewModifier {
    @State var font = Font.custom("Poppins-Black", size: 24)

    func body(content: Content) -> some View {
        return content
            .font(font)
    }
}

struct MoviesView: View {
    @ObservedObject var movieViewModel: MoviesViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                ScrollView {
                    UpcomingMovies(movieViewModel: movieViewModel, upcomingMovies: movieViewModel.upcoming)
                    TopRatedMovies(movieViewModel: movieViewModel, topRatedMovies: movieViewModel.topRated)
                    PopularMovies(movieViewModel: movieViewModel, popularMovies: movieViewModel.popular)
                    Spacer()
                }
            }
            .onAppear {
                Task {
                    await movieViewModel.getTopRatedMovies()
                    await movieViewModel.getUpcomingMovies()
                    await movieViewModel.getPopularMovies()
                }
            }
            .padding(EdgeInsets(top: 50, leading: 20, bottom: 0, trailing: 20))
        }
    }
}

struct UpcomingMovies: View {
    @ObservedObject var movieViewModel: MoviesViewModel
    var upcomingMovies: [Movie]
    var body: some View {
        MoviesCollectionView(movieViewModel: movieViewModel, title: "UPCOMING", movieList: upcomingMovies)
    }
}

struct TopRatedMovies: View {
    @ObservedObject var movieViewModel: MoviesViewModel
    var topRatedMovies: [Movie]

    var body: some View {
        MoviesCollectionView(movieViewModel: movieViewModel, title: "TOP RATED", movieList: topRatedMovies)
    }
}

struct PopularMovies: View {
    @ObservedObject var movieViewModel: MoviesViewModel
    var popularMovies: [Movie]

    var body: some View {
        MoviesCollectionView(movieViewModel: movieViewModel, title: "POPULAR", movieList: popularMovies)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Movies()
    }
}
