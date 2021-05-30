//
//  MovieViewModel.swift
//  MovieTheater
//
//  Created by Map04 on 2021-04-13.
//

import Foundation

class MovieViewModel {
    var movies: [Movie]
    var videoKeys: [VideoKey]
    var selectedMovieIndex: Int = 0
    init() {
        self.movies = [Movie]()
        self.videoKeys = [VideoKey]()

    }
    let movieStore = MovieStore ()
    
    func loadMovies(from: String, completionHandler: @escaping () -> Void) {
        movieStore.fetchMovies(from: from) { (movies) in
            DispatchQueue.main.async {
                self.movies = movies.movies
                completionHandler()
            }
            } errorHandler: { (errors) in
                print(errors)
            }
    }
    
    func searchMovie(from: String, completionHandler: @escaping () -> Void) {
        movieStore.searchMovie (query: from) { (movies) in
            DispatchQueue.main.async {
                self.movies = movies.movies
                completionHandler()
            }
            } errorHandler: { (errors) in
                print(errors)
            }
    }
    
    func loadVideo (id: Int, completionHandler: @escaping () -> Void) {
        movieStore.fetchVideo(id: id) { (videoKeys) in
            DispatchQueue.main.async {
                self.videoKeys = videoKeys
                completionHandler()
            }
            } errorHandler: { (errors) in
                print(errors)
            }
    }
    
    func updateMovieIndex(_ index: Int) -> Void {
        selectedMovieIndex = index
    }
    
    func fetchMovieIndex() -> Int {
        return selectedMovieIndex
    }
}
