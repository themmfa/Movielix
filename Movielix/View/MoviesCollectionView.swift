//
//  MoviesCollectionView.swift
//  Movielix
//
//  Created by Fatih Erdoğan on 12.10.2022.
//

import SwiftUI

struct MoviesCollectionView: View {
    var title: String
    var movieList: [Movie]

    private func getScale(proxy: GeometryProxy) -> CGFloat {
        var scale: CGFloat = 1
        let x = proxy.frame(in: .global).minX
        let diff = abs(x)

        if diff < 100 {
            scale = 1 + (100 - diff) / 500
        }

        return scale
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .modifier(CustomTextModifier())

            ScrollView(.horizontal) {
                HStack {
                    ForEach(movieList, id: \.self) { movie in
                        GeometryReader { proxy in
                            let scale = getScale(proxy: proxy)
                            NavigationLink(destination: MovieDetail(movie: movie)) {
                                MovieVStack(url: "https://image.tmdb.org/t/p/w500\(movie.poster_path)", scale: scale)
                            }
                        }
                        .frame(width: 100, height: 250)
                    }
                    .padding()
                }
            }
        }
    }

    struct MovieVStack: View {
        var url: String
        var scale: CGFloat

        var body: some View {
            VStack {
                AsyncImage(url: URL(string: url)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 0.5)
                        )
                        .clipped()
                        .cornerRadius(12)
                        .scaleEffect(CGSize(width: scale, height: scale))

                } placeholder: {
                    ProgressView()
                }
            }
        }
    }
}

struct MoviesCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesCollectionView(title: "", movieList: [])
    }
}
