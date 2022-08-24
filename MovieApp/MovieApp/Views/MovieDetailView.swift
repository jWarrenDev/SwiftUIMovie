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
            
            if movieDetailState.movie != nil {
                MovieDetailListView(movie: self.movieDetailState.movie!)
                    .listStyle(.plain)
                
                
            }
                
                
//            VStack {
//                MovieDetailListView(movie: self.movieDetailState.movie!)
//                MovieDetailImage()
//            }
        }
        .navigationTitle(movieDetailState.movie?.title ?? "")
        .onAppear {
            self.movieDetailState.loadMovie(id: self.movieId)
        }
    }
}

// Create the MovieDetailList View

struct MovieDetailListView: View {
    
    let movie: Movie
    let imageLoader = ImageLoader()
    
    var body: some View {
        List {
            MovieDetailImage(imageLoader: imageLoader, imageURL: self.movie.backdropURL)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowSeparator(.hidden)
            
            HStack {
                Text(movie.genreText)
                Text(movie.overview)
                Text(movie.ratingText)
            }
                
        }
        
        
    }
}

// Create the image MovieDetailImage
// this is going to pass the image into the view. **TODO: gotta learn Async after this.. I dont think this is the right way to go about it.

struct MovieDetailImage: View {
    
    @ObservedObject var imageLoader = ImageLoader()
    let imageURL: URL
    
    var body: some View {
        ZStack {
           // Rectangle().frame(width: 200, height: 200)
           //     .foregroundColor(Color.gray)
            
            Rectangle().fill(Color.gray.opacity(0.3))
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
        .onAppear {
            self.imageLoader.loadImage(with: self.imageURL)
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
