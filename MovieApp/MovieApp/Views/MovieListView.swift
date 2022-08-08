//
//  MovieListView.swift
//  MovieApp
//
//  Created by Jerrick Warren on 8/8/22.
//

import SwiftUI

struct MovieListView: View {
    
    // add observedObjects
    @ObservedObject private var nowPlayingState = MovieListState()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
