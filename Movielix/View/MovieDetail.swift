//
//  MovieDetail.swift
//  Movielix
//
//  Created by Fatih Erdoğan on 12.10.2022.
//

import SwiftUI

var dummy = Movie(adult: false, id: 642885, original_language: "en", original_title: "Hocus Pocus 2", overview: "It’s been 29 years since someone lit the Black Flame Candle and resurrected the 17th-century sisters, and they are looking for revenge. Now it is up to three high-school students to stop the ravenous witches from wreaking a new kind of havoc on Salem before dawn on All Hallow’s Eve.", popularity: 6354.721, poster_path: "/7ze7YNmUaX81ufctGqt0AgHxRtL.jpg", release_date: "2022-09-27", title: "Hocus Pocus 2", video: false, vote_average: 7.8, vote_count: 554)

let dummy_suggestions = [
    Movie(adult: false, id: 642885, original_language: "en", original_title: "Hocus Pocus 2", overview: "It’s been 29 years since someone lit the Black Flame Candle and resurrected the 17th-century sisters, and they are looking for revenge. Now it is up to three high-school students to stop the ravenous witches from wreaking a new kind of havoc on Salem before dawn on All Hallow’s Eve.", popularity: 6354.721, poster_path: "/7ze7YNmUaX81ufctGqt0AgHxRtL.jpg", release_date: "2022-09-27", title: "Hocus Pocus 2", video: false, vote_average: 7.8, vote_count: 554),
    Movie(adult: false, id: 642885, original_language: "en", original_title: "Hocus Pocus 2", overview: "It’s been 29 years since someone lit the Black Flame Candle and resurrected the 17th-century sisters, and they are looking for revenge. Now it is up to three high-school students to stop the ravenous witches from wreaking a new kind of havoc on Salem before dawn on All Hallow’s Eve.", popularity: 6354.721, poster_path: "/7ze7YNmUaX81ufctGqt0AgHxRtL.jpg", release_date: "2022-09-27", title: "Hocus Pocus 2", video: false, vote_average: 7.8, vote_count: 554),
    Movie(adult: false, id: 642885, original_language: "en", original_title: "Hocus Pocus 2", overview: "It’s been 29 years since someone lit the Black Flame Candle and resurrected the 17th-century sisters, and they are looking for revenge. Now it is up to three high-school students to stop the ravenous witches from wreaking a new kind of havoc on Salem before dawn on All Hallow’s Eve.", popularity: 6354.721, poster_path: "/7ze7YNmUaX81ufctGqt0AgHxRtL.jpg", release_date: "2022-09-27", title: "Hocus Pocus 2", video: false, vote_average: 7.8, vote_count: 554),
    Movie(adult: false, id: 642885, original_language: "en", original_title: "Hocus Pocus 2", overview: "It’s been 29 years since someone lit the Black Flame Candle and resurrected the 17th-century sisters, and they are looking for revenge. Now it is up to three high-school students to stop the ravenous witches from wreaking a new kind of havoc on Salem before dawn on All Hallow’s Eve.", popularity: 6354.721, poster_path: "/7ze7YNmUaX81ufctGqt0AgHxRtL.jpg", release_date: "2022-09-27", title: "Hocus Pocus 2", video: false, vote_average: 7.8, vote_count: 554),
    Movie(adult: false, id: 642885, original_language: "en", original_title: "Hocus Pocus 2", overview: "It’s been 29 years since someone lit the Black Flame Candle and resurrected the 17th-century sisters, and they are looking for revenge. Now it is up to three high-school students to stop the ravenous witches from wreaking a new kind of havoc on Salem before dawn on All Hallow’s Eve.", popularity: 6354.721, poster_path: "/7ze7YNmUaX81ufctGqt0AgHxRtL.jpg", release_date: "2022-09-27", title: "Hocus Pocus 2", video: false, vote_average: 7.8, vote_count: 554)
]

struct MovieDetail: View {
    @ObservedObject var movieViewModel: MoviesViewModel
    var movie: Movie

    var body: some View {
        VStack {
            AsyncImageLoader(movie: movie)

            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.white)
                    .padding(.top, -300)

                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(movie.title)
                            .modifier(CustomTextModifier())
                        RatingView(movieRating: movie.vote_average)
                        DescriptionView(movieDesc: movie.overview)
                        SimilarMoviesView(movieViewModel: movieViewModel, movie: movie)
                        CastView(movieViewModel: movieViewModel, movie: movie)
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.top, -250)
            }
        }
    }
}

private struct CastView: View {
    @ObservedObject var movieViewModel: MoviesViewModel
    var movie: Movie
    var baseUrl = "https://image.tmdb.org/t/p/w500"

    var body: some View {
        VStack(alignment: .leading) {
            Text("Casts")
                .modifier(CustomTextModifier(font: Font.custom("Poppins-Bold", size: 24)))
            ScrollView(.horizontal) {
                HStack {
                    ForEach(movieViewModel.casts, id: \.self) { cast in
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(cast.profile_path ?? "")")) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)

                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }
            .onAppear {
                Task {
                    await movieViewModel.getCasts(id: movie.id)
                }
            }
        }
    }
}

private struct SimilarMoviesView: View {
    @ObservedObject var movieViewModel: MoviesViewModel
    var movie: Movie

    var body: some View {
        VStack(alignment: .leading) {
            Text("Similar Movies")
                .modifier(CustomTextModifier(font: Font.custom("Poppins-Bold", size: 24)))
            ScrollView(.horizontal) {
                HStack {
                    ForEach(movieViewModel.similar, id: \.self) { movie in
                        NavigationLink(destination: MovieDetail(movieViewModel: movieViewModel, movie: movie)) {
                            AsyncImageLoader(movie: movie, height: 100, width: 100)
                        }
                    }
                }
            }
            .onAppear {
                Task {
                    await movieViewModel.getSimilarMovies(id: movie.id)
                }
            }
        }
    }
}

private struct DescriptionView: View {
    var movieDesc: String
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Description")
                .modifier(CustomTextModifier(font: Font.custom("Poppins-Bold", size: 24)))
            Text(movieDesc)
                .modifier(CustomTextModifier(font: Font.custom("Poppins-Medium", size: 16)))
                .foregroundColor(.gray)
        }
    }
}

private struct RatingView: View {
    var movieRating: Double
    var body: some View {
        HStack {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
            Text("\(movieRating, specifier: "%.1f") / 10")
                .foregroundColor(.gray)
        }
    }
}
