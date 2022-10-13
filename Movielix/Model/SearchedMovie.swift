//
//  SearchedMovie.swift
//  Movielix
//
//  Created by Fatih Erdoğan on 13.10.2022.
//

import Foundation

struct Results: Decodable {
    let results: [SearchedMovies]
}

// MARK: - Result

struct SearchedMovies: Decodable {
    let id: Int
}
