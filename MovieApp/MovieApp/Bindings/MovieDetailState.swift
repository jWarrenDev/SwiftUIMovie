//
//  MovieDetailState.swift
//  MovieApp
//
//  Created by Jerrick Warren on 8/15/22.
//

import SwiftUI

// create an observable object

class MovieDetailState: ObservableObject {
    
    // dependancy inject
    
    private let movieService: MovieService
    
    
    // publish your variables
    
    @Published var movie: Movie?
    @Published var isLoading = false
    @Published var error: NSError?
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
    func loadMovie(id: Int) {
        self.movie = nil
        self.isLoading = false
        self.movieService.fetchMovie(id: id) {[weak self] (result) in
            guard let self = self else {return}
            
            self.isLoading = false
            
            switch result {
            case .success(let movie):
                self.movie = movie
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}
