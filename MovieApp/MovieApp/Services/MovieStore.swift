//
//  MovieStore.swift
//  MovieApp
//
//  Created by Jerrick Warren on 7/31/22.
//

import Foundation

class MovieStore: MovieService {
    
    static let shared = MovieStore()
    private init() {}
    
    private let apiKey = "15a8deba1ab17a4186ef50ddab455438"
    private let baseAPIUrl = "http://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        // check it the url exist, need a guard satement
        
        guard let url = URL(string: "\(baseAPIUrl)/movie/\(endpoint.rawValue)" else {completion(.failure(.invalidEndpoint))
            return
        }
       // TODO: ADD the LoadURLandDECODE method here
    }
    
    func fetchMovies(from endpoint: MovieListEndpoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        <#code#>
    }
    
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        <#code#>
    }
                            
    // helper function to make sure that the the url is loaded and decoded
    // the params are going to take a dictionary
        
        private func loadURLandDecode<D: Decodable>(url: URL, params: [String : String]? = nil , completion: @escaping (Result <D, MovieError>) -> ()) {
            
        }
     
}
