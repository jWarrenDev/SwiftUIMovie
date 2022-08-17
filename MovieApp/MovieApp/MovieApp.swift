//
//  MovieApp.swift
//  MovieApp
//
//  Created by Jerrick Warren on 7/29/22.
//

import SwiftUI

@main
struct MovieApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MovieDetailView(movieId: 550)
           // MovieListView()
//            ContentView()
//            DataContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
