//
//  MoviePostercard.swift
//  MovieApp
//
//  Created by Jerrick Warren on 8/6/22.
//

import SwiftUI

struct MoviePostercard: View {
    
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        
        ZStack{
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .shadow(radius: 4)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .cornerRadius(8)
                    .shadow(radius: 4)
                
                Text(movie.title)
            }
        }
        .frame(width: 204, height: 306)
        .onAppear{
            self.imageLoader.loadImage(with: self.movie.posterURL)
        }
        
    }
}

struct MoviePostercard_Previews: PreviewProvider {
    static var previews: some View {
        MoviePostercard(movie: Movie.stubbedMovie)
    }
}
