//
//  Movie.swift
//  Movielix
//
//  Created by Fatih Erdoğan on 12.10.2022.
//

import Foundation

struct NowPlaying: Decodable {
    let results: [Movie]
}

// MARK: - Welcome

struct Movie: Decodable, Hashable {
    let adult: Bool
    let genre_ids: [Int]
    let id: Int
    let original_language, original_title, overview: String
    let popularity: Double
    let poster_path, release_date, title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
}
