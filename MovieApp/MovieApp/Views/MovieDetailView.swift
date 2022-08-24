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
    
    @State private var selectedTrailer: MovieVideo?
    
    var body: some View {
        List {
            MovieDetailImage(imageLoader: imageLoader, imageURL: self.movie.backdropURL)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            // .listRowSeparator(.hidden)
            
            HStack {
                Text(movie.genreText)
                Text("﹒")
                Text(movie.yearText)
                Text(movie.durationText)
            }
            .listRowSeparator(.hidden)
            
            Text(movie.overview)
            HStack {
                if !movie.ratingText.isEmpty {
                    Text(movie.ratingText).foregroundColor(.yellow)
                }
                Text(movie.scoreText)
            }
            .listRowSeparator(.hidden)
            
            Divider()
                .listRowSeparator(.hidden)
            
            HStack(alignment: .top, spacing: 4) {
                VStack(alignment: .leading, spacing: 4){
                    Text("Starring").font(.headline)
                    ForEach(self.movie.cast!.prefix(9)) { cast in
                        Text(cast.name)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                if movie.crew != nil && movie.crew!.count > 0 {
                    VStack(alignment: .leading, spacing: 4) {
                        if movie.directors != nil && movie.directors!.count > 0 {
                            Text("Director(s)")
                                .font(.headline)
                            ForEach(self.movie.directors!.prefix(2)) { crew in
                                Text(crew.name)
                                
                            }
                        }
                        
                        if movie.producers  != nil && movie.producers!.count > 0 {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Producer(s)")
                                    .font(.headline)
                                    .padding(.top)
                                ForEach(self.movie.producers!.prefix(2)) { crew in
                                    Text(crew.name)}
                            }
                        }
                        
                        
                        if movie.screenWriters  != nil && movie.screenWriters!.count > 0 {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Screenwriter(s)")
                                    .font(.headline)
                                    .padding(.top)
                                ForEach(self.movie.screenWriters!.prefix(2)) { crew in
                                    Text(crew.name)}
                            }
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                
            }
            // .listRowSeparator(.hidden)
            
            if movie.youtubeTrailers != nil && movie.youtubeTrailers!.count > 0 {
                Text("Trailers")
                    .font(.headline)
                    .padding(.top)
                
                
                ForEach(movie.youtubeTrailers!) { trailer in
                    Button(action: {
                        self.selectedTrailer = trailer
                    }) {
                        HStack {
                            Text(trailer.name)
                                .listRowSeparator(.hidden)
                            Spacer()
                            Image(systemName: "play.circle.fill")
                                .foregroundColor(.blue)
                            
                        }
                    }
                }
                // .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .sheet(item: self.$selectedTrailer) { trailer in
            SafariView(url: trailer.youtubeURL!)
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
