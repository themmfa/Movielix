//
//  MovieDetail.swift
//  Movielix
//
//  Created by Fatih Erdoğan on 12.10.2022.
//

import SwiftUI

var dummy = Movie(adult: false, genre_ids: [
    14,
    35,
    10751
], id: 642885, original_language: "en", original_title: "Hocus Pocus 2", overview: "It’s been 29 years since someone lit the Black Flame Candle and resurrected the 17th-century sisters, and they are looking for revenge. Now it is up to three high-school students to stop the ravenous witches from wreaking a new kind of havoc on Salem before dawn on All Hallow’s Eve.", popularity: 6354.721, poster_path: "/7ze7YNmUaX81ufctGqt0AgHxRtL.jpg", release_date: "2022-09-27", title: "Hocus Pocus 2", video: false, vote_average: 7.8, vote_count: 554)

let dummy_suggestions = [
    Movie(adult: false, genre_ids: [
        14,
        35,
        10751
    ], id: 642885, original_language: "en", original_title: "Hocus Pocus 2", overview: "It’s been 29 years since someone lit the Black Flame Candle and resurrected the 17th-century sisters, and they are looking for revenge. Now it is up to three high-school students to stop the ravenous witches from wreaking a new kind of havoc on Salem before dawn on All Hallow’s Eve.", popularity: 6354.721, poster_path: "/7ze7YNmUaX81ufctGqt0AgHxRtL.jpg", release_date: "2022-09-27", title: "Hocus Pocus 2", video: false, vote_average: 7.8, vote_count: 554),
    Movie(adult: false, genre_ids: [
        14,
        35,
        10751
    ], id: 642885, original_language: "en", original_title: "Hocus Pocus 2", overview: "It’s been 29 years since someone lit the Black Flame Candle and resurrected the 17th-century sisters, and they are looking for revenge. Now it is up to three high-school students to stop the ravenous witches from wreaking a new kind of havoc on Salem before dawn on All Hallow’s Eve.", popularity: 6354.721, poster_path: "/7ze7YNmUaX81ufctGqt0AgHxRtL.jpg", release_date: "2022-09-27", title: "Hocus Pocus 2", video: false, vote_average: 7.8, vote_count: 554),
    Movie(adult: false, genre_ids: [
        14,
        35,
        10751
    ], id: 642885, original_language: "en", original_title: "Hocus Pocus 2", overview: "It’s been 29 years since someone lit the Black Flame Candle and resurrected the 17th-century sisters, and they are looking for revenge. Now it is up to three high-school students to stop the ravenous witches from wreaking a new kind of havoc on Salem before dawn on All Hallow’s Eve.", popularity: 6354.721, poster_path: "/7ze7YNmUaX81ufctGqt0AgHxRtL.jpg", release_date: "2022-09-27", title: "Hocus Pocus 2", video: false, vote_average: 7.8, vote_count: 554),
    Movie(adult: false, genre_ids: [
        14,
        35,
        10751
    ], id: 642885, original_language: "en", original_title: "Hocus Pocus 2", overview: "It’s been 29 years since someone lit the Black Flame Candle and resurrected the 17th-century sisters, and they are looking for revenge. Now it is up to three high-school students to stop the ravenous witches from wreaking a new kind of havoc on Salem before dawn on All Hallow’s Eve.", popularity: 6354.721, poster_path: "/7ze7YNmUaX81ufctGqt0AgHxRtL.jpg", release_date: "2022-09-27", title: "Hocus Pocus 2", video: false, vote_average: 7.8, vote_count: 554),
    Movie(adult: false, genre_ids: [
        14,
        35,
        10751
    ], id: 642885, original_language: "en", original_title: "Hocus Pocus 2", overview: "It’s been 29 years since someone lit the Black Flame Candle and resurrected the 17th-century sisters, and they are looking for revenge. Now it is up to three high-school students to stop the ravenous witches from wreaking a new kind of havoc on Salem before dawn on All Hallow’s Eve.", popularity: 6354.721, poster_path: "/7ze7YNmUaX81ufctGqt0AgHxRtL.jpg", release_date: "2022-09-27", title: "Hocus Pocus 2", video: false, vote_average: 7.8, vote_count: 554)
]

struct MovieDetail: View {
    var movie: Movie

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)")) { image in
                image
                    .resizable()
                    .scaledToFill()

            } placeholder: {
                Image(systemName: "photo.artframe")
                    .resizable()
                    .scaledToFill()
            }

            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.white)
                    .frame(width: .infinity, height: .infinity)
                    .padding(.top, -400)

                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(movie.title)
                            .modifier(CustomTextModifier())
                        RatingView(movieRating: movie.vote_average)
                        DescriptionView(movieDesc: movie.overview)

                        SimilarMoviesView(similar: dummy_suggestions)
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.top, -350)
            }
        }
    }
}

private struct SimilarMoviesView: View {
    var similar: [Movie]
    var body: some View {
        VStack(alignment: .leading) {
            Text("Similar Movies")
                .modifier(CustomTextModifier(font: Font.custom("Poppins-Bold", size: 24)))
            ScrollView(.horizontal) {
                HStack {
                    ForEach(similar, id: \.self) { similar in
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(similar.poster_path)")) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                        } placeholder: {
                            Image(systemName: "photo.artframe")
                                .resizable()
                                .scaledToFill()
                        }
                    }
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

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetail(movie: dummy)
    }
}
