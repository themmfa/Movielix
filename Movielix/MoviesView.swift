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
                            SearchView()
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
                    UpcomingMovies(upcomingMovies: movieViewModel.upcoming)
                    TopRatedMovies(topRatedMovies: movieViewModel.topRated)
                    PopularMovies(popularMovies: movieViewModel.popular)
                    Spacer()
                }
            }
            .onAppear {
                Task{
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
    var upcomingMovies: [Movie]
    var body: some View {
        MoviesCollectionView(title: "UPCOMING", movieList: upcomingMovies)
    }
}

struct TopRatedMovies: View {
    var topRatedMovies: [Movie]

    var body: some View {
        MoviesCollectionView(title: "TOP RATED", movieList: topRatedMovies)
    }
}

struct PopularMovies: View {
    var popularMovies: [Movie]

    var body: some View {
        MoviesCollectionView(title: "POPULAR", movieList: popularMovies)
    }
}

struct SearchView: View {
    var body: some View {
        VStack {
            Text("Search View")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Movies()
    }
}
