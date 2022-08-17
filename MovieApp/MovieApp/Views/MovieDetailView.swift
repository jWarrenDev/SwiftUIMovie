//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Jerrick Warren on 8/15/22.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movieId: Int
    @ObservedObject private var movieDetailState = MovieDetailState()
    
    var body: some View {
        ZStack {
            LoadingView(isLoading: self.movieDetailState.isLoading, error: self.movieDetailState.error) {
                self.movieDetailState.loadMovie(id: self.movieId)
            }
            VStack {
                MovieDetailListView()
                MovieDetailImage()
            }
        }
        .navigationTitle(movieDetailState.movie?.title ?? "")
        .onAppear {
            self.movieDetailState.loadMovie(id: self.movieId)
        }
    }
}

// Create the MovieDetailList View

struct MovieDetailListView: View {
    
   // let movie: Movie
    
    var body: some View {
        Text("hello")
    }
}

// Create the image MovieDetailImage
// this is going to pass the image into the view. **TODO: gotta learn Async after this.. I dont think this is the right way to go about it.

struct MovieDetailImage: View {
    
    var body: some View {
        ZStack {
            Rectangle().frame(width: 200, height: 200)
                .foregroundColor(Color.gray)
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieDetailView(movieId: Movie.stubbedMovie.id)
        }
    }
}
