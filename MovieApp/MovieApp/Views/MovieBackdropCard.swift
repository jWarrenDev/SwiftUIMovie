//
//  MovieBackdropCard.swift
//  MovieApp
//
//  Created by Jerrick Warren on 8/4/22.
//

import SwiftUI

struct MovieBackdropCard: View {
    
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                
                if self.imageLoader.image != nil {
                    Image(uiImage: self.imageLoader.image!)
                    .resizable()
                }
            }
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(8)
            .shadow(radius: 5)
            Text(movie.title)
        }
        .onAppear {
            self.imageLoader.loadImage(with: self.movie.backdropURL)
        }
    }
}

struct MovieBackDropCard_Previews: PreviewProvider {
    static var previews: some View {
        MovieBackdropCard(movie: Movie.stubbedMovie)
    }
}
