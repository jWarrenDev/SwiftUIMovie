//
//  MovieService.swift
//  MovieApp
//
//  Created by Jerrick Warren on 7/29/22.
//

import Foundation

enum MovieListEndpoint: String, CaseIterable {
    case nowPlaying = "now_playing"
    case upcoming
    case topRated = "top_rated"
    case popular
    
    var description: String {
        switch self {
        case .nowPlaying:
            return "Now Playing"
        case .upcoming:
            return "Upcoming"
        case .topRated:
            return "Top Rated"
        case . popular:
            return "Popular"
        }
    }
}
