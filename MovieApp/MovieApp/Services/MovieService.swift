//
//  MovieService.swift
//  MovieApp
//
//  Created by Jerrick Warren on 7/29/22.
//

import Foundation

enum MovieError: Error, CustomNSError {
    case apiError
    case invalidEndpoint
    case invalidRepsonse
    case noData
    case serializationError
    
    var localizedDescription: String {
        switch self {
        case .apiError:
            return "Error with the Api and fetching Data"
        case .invalidRepsonse:
            return "Invalid response"
        case .invalidEndpoint:
            return "Invalid Endpoint"
        case .noData:
            return "No data was returned"
        case .serializationError:
            return "Serilization was not completed properly."
        }
    }
}

enum MovieListEndpoint: String, CaseIterable {
    case nowPlaying = "now_playing"
    case upcoming
    case topRated = "top_rated"
    case popular
    case trending
    
    var description: String {
        switch self {
        case .nowPlaying:
            return "Now Playing"
        case .upcoming:
            return "Upcoming"
        case .topRated:
            return "Top Rated"
        case .popular:
            return "Popular"
        case .trending:
            return "Trending"
        }
    }
}


protocol MovieService {
    
    func fetchMovies(from endpoint: MovieListEndpoint, completion: @escaping (Result<MovieResponse, MovieError>) -> () )
    
    func fetchTrendingMovies(from endpoint: MovieListEndpoint, completion: @escaping (Result<MovieResponse, MovieError>) -> () )

    func fetchMovie(id: Int , completion: @escaping (Result<Movie, MovieError>) -> () )
    
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> () )
    
}
