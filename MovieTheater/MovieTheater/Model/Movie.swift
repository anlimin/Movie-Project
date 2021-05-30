//
//  Movie.swift
//  MovieTheater
//
//  Created by Map04 on 2021-04-12.
//

import Foundation

struct Movie: Codable, Equatable {
    let id: Int?
    let posterPath: String?
    let backdropPath: String?
    var title: String?
    var releaseDate: String?
    var rating: Double?
    var overview: String?
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/original\(backdropPath ?? "")")!
    }
    
    enum CodingKeys: String, CodingKey {
        case id,
             posterPath = "poster_path",
             backdropPath = "backdrop_path",
             title,
             releaseDate = "release_date",
             rating = "vote_average",
             overview
    }
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("movies").appendingPathExtension("plist")

    static func saveToFile (_ movies: [Movie]) {
        let propertyListEncoder = PropertyListEncoder()
         print(archiveURL)
       let encodeMovies = try? propertyListEncoder.encode(movies)
        try? encodeMovies?.write(to: archiveURL, options: .noFileProtection)
    }

    static func loadFromFile () -> [Movie]? {
        guard let retrievedMovies = try? Data(contentsOf: archiveURL) else {return nil}
        let propertyListDecoder = PropertyListDecoder()
        print(archiveURL)
        return try? propertyListDecoder.decode(Array<Movie>.self, from: retrievedMovies)
    }
}

struct MoviesResponse: Codable {
    let page: Int
    let numResults: Int
    let numPages: Int
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case page, numResults = "total_results", numPages = "total_pages", movies = "results"
    }
}

struct MovieDetailResults: Codable {
    let genres : [Genres]
}

struct Genres: Codable {
    let id: Int
    let name: String
}

var favorites = [Movie]()
