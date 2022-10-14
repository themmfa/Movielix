//
//  AsyncImageLoader.swift
//  Movielix
//
//  Created by Fatih Erdoğan on 14.10.2022.
//

import SwiftUI

struct AsyncImageLoader: View {
    var movie: Movie
    var height: CGFloat?
    var width: CGFloat?

    var baseUrl = "https://image.tmdb.org/t/p/w500"
    var body: some View {
        AsyncImage(url: URL(string: "\(baseUrl)\(movie.poster_path)")) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: width, height: height)

        } placeholder: {
            ProgressView()
        }
    }
}
