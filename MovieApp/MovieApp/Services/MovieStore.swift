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
    
    func fetchMovies(from endpoint: MovieListEndpoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIUrl)/movie/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLandDecode(url: url, completion: completion)
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIUrl)/movie/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        self.loadURLandDecode(url: url, params: [
            "append_to_response": "videos,credits"
        ] , completion: completion)
    }
    
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIUrl)/search/movie") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLandDecode(url: url, params: [
            "language" : "en-US",
            "include_adult" : "false",
            "region": "US",
            "query": query
            ],completion: completion)
    }
    
  
                            
    // helper function to make sure that the the url is loaded and decoded
    // the params are going to take a dictionary
        
    private func loadURLandDecode<D: Decodable>(url: URL, params: [String : String]? = nil , completion: @escaping (Result <D, MovieError>) -> ()) {
            
            // this must be a var because you will be assigning it later
            guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                completion(.failure(.invalidEndpoint))
                return
            }
            
            var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
            if let params = params {
                queryItems.append(contentsOf: params.map {URLQueryItem(name: $0.key, value: $0.value)})
            }
            
            urlComponents.queryItems = queryItems
            
            guard let finalURL = urlComponents.url else {
                completion(.failure(.invalidEndpoint))
                return
            }
            
            // make your urlSession, remember this data task returns a strongly reference object.  Make it weak self.
            
            urlSession.dataTask(with: finalURL) { [weak self] (data, response, error) in
                
                guard let self = self else {return}
                
                // Error
                if error != nil {
                    self.completeOnMainThread(with: .failure(.apiError), completion: completion)
                    return
                }
                
                // Response
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    self.completeOnMainThread(with: .failure(.invalidRepsonse), completion: completion)
                    return
                }
                
                // Data
                guard let data = data else {
                    self.completeOnMainThread(with: .failure(.noData), completion: completion)
                    return
                }
                
                do {
                    let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                    self.completeOnMainThread(with: .success(decodedResponse), completion: completion)
                    print(decodedResponse)
                } catch {
                    self.completeOnMainThread(with: .failure(.serializationError), completion: completion)
                }
                
                
            }.resume()
        }
    
    
    private func completeOnMainThread<D:Decodable>(with result: Result<D, MovieError>, completion: @escaping (Result<D, MovieError>) -> ()) {
            DispatchQueue.main.async {
                completion(result)
            }
    }
     
}
                            

