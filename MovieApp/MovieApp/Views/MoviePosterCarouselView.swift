//
//  MoviePosterCarouselView.swift
//  MovieApp
//
//  Created by Jerrick Warren on 8/6/22.
//

import SwiftUI

struct MoviePosterCarouselView: View {
    
    let title: String
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16){
                    ForEach(self.movies) { movie in
                        MoviePostercard(movie: movie)
                            .padding(.leading, movie.id == self.movies.first!.id ? 16 : 0)
                            .padding(.leading, movie.id == self.movies.last!.id ? 16 : 0)
                    }
                    
                }
            }
            
        }
        
    }
}

struct MoviePosterCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCarouselView(title: "Now Playing", movies: Movie.stubbedMovies)
    }
}
