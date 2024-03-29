//
//  Movie+Stub.swift
//  MovieApp
//
//  Created by Jerrick Warren on 8/4/22.
//

import Foundation

extension Movie {
    
    // this is kinda cool to be creating your own stub and load from there until you get the API work for you.
    // I llike this approach a lot better.
    // Will try to implement this in another app as well
    
    static var stubbedMovies: [Movie] {
        let response: MovieResponse? = try? Bundle.main.loadAndDecodeJSON(filename: "movie_list")
        return response!.results
    }
    
    static var stubbedMovie: Movie {
        stubbedMovies[0]
    }
}


extension Bundle {
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = Utils.jsonDecoder
        let decodedModel = try jsonDecoder.decode(D.self, from: data)
     //   print(decodedModel)
        return decodedModel
        
    }
}
