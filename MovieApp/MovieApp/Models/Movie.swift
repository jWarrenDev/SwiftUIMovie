//
//  Movie.swift
//  MovieApp
//
//  Created by Jerrick Warren on 7/29/22.
//

import Foundation


struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable, Identifiable {
    
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let voteAverage: Double
    let overview: String
    let releaseDate: String?
    let runtime: Int?
    let voteCount: Int
    
    let genres: [MovieGenre]?
    let credits: MovieCredit?
    let videos: MovieVideoResponse?
    
    
    // MARK: Formatters
    
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static private let durationFormmater: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    
    
    // MARK: Computed properties
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    var genretext: String {
        genres?.first?.name ?? "n/a"
    }
    
    // use reduce to get what you want
    
    var ratingText: String {
        let rating = Int(voteAverage)
        let ratingtext = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "⭐️"
        }
        return ratingtext
    }
    
    var scoreText: String {
        guard ratingText.count > 0 else {
            return "n/a"
        }
        return "\(ratingText.count)/10"
    }

    var yearText: String {
        guard let releaseDate = self.releaseDate, let date = Utils.dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        
        return Movie.yearFormatter.string(from: date)
    }
    
    var durationText: String {
        guard let runtime = self.runtime, runtime > 0 else {
            return "n/a"
        }
        return Movie.durationFormmater.string(from: TimeInterval(runtime) * 60) ?? "n/a"
    }
    
    var cast: [MovieCast]? {
        credits?.cast
    }
    
    var crew: [MovieCrew]? {
        credits?.crew
    }
    
    // Filter the job to see the crew titles
    
    var directors: [MovieCrew]? {
        crew?.filter{ $0.job.lowercased() == "director" }
    }
    
    var producers: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "producer" }
    }
    
    var screenWriters: [MovieCrew]? {
        crew?.filter{ $0.job.lowercased() == "story"}
    }
    
    var youtubeTrailers: [MovieVideo]? {
        videos?.results.filter{$0.youtubeURL != nil}
    }
    
}

// MARK: More Struct Models

struct MovieGenre: Decodable {
    let name: String
}

struct MovieCredit: Decodable {
    let cast: [MovieCast]
    let crew: [MovieCrew]
}

struct MovieCast: Decodable, Identifiable {
    let id: Int
    let character: String
    let name: String
}

struct MovieCrew: Decodable, Identifiable {
    let id: Int
    let job: String
    let name: String
}

struct MovieVideoResponse: Decodable {
    let results: [MovieVideo]
}

struct MovieVideo: Decodable, Identifiable {
    var id: Int
    var key: String
    var name: String
    var site: String
    
    var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        
        return URL(string: "https://youtube.com/watch?v=\(key)")
    }
}
