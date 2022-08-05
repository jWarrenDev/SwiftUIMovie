//
//  Movie.swift
//  MovieApp
//
//  Created by Jerrick Warren on 7/29/22.
//

import Foundation


struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let voteAverage: Double
    let overview: String
    let releaseDate: String
    let runtime: Int?
    let voteCount: Int
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
}
