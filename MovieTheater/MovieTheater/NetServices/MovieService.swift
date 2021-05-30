//
//  MovieService.swift
//  MovieTheater
//
//  Created by Map04 on 2021-04-12.
//

import Foundation

protocol MovieService {
    
    func fetchMovies(from endpoint: String, params: [String: String]?, successHandler: @escaping (_ response: MoviesResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
    func fetchMovie(id: Int, successHandler: @escaping (_ response: Movie) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
    func searchMovie(query: String, params: [String: String]?, successHandler: @escaping (_ response: MoviesResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
    func fetchVideo(id: Int, successHandler: @escaping (_ response: [VideoKey]) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
}

enum MovieError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
}
