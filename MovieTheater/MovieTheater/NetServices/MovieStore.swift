//
//  MovieStore.swift
//  MovieTheater
//
//  Created by Map04 on 2021-04-12.
//

import Foundation

class MovieStore: MovieService {
   
   static let shared = MovieStore()
   init() {}
   let apiKey = "bcbf2e03ce17e9d9f181eff4722ead5a"
   let baseAPIURL = "https://api.themoviedb.org/3"
   let urlSession = URLSession.shared
   let jsonDecoder = JSONDecoder()
   
   func fetchMovies(from endpoint: String, params: [String: String]? = nil, successHandler: @escaping ( _ response: MoviesResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void) {
       
       guard var urlComponents = URLComponents(string: "\(baseAPIURL)/movie/\(endpoint)") else {
           errorHandler(MovieError.invalidEndpoint)
           return
       }
       
       var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
       if let params = params {
           queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
       }
       urlComponents.queryItems = queryItems
       
       guard let url = urlComponents.url else {
           errorHandler(MovieError.invalidEndpoint)
           return
       }
       
       urlSession.dataTask(with: url) { (data, response, error) in
           guard let data = data else {
               self.handleError(errorHandler: errorHandler, error: MovieError.noData)
               return
           }
        
           do {
               let moviesResponse = try self.jsonDecoder.decode(MoviesResponse.self, from: data)
                   successHandler(moviesResponse)
           } catch {
               print("error")
               self.handleError(errorHandler: errorHandler, error: MovieError.serializationError)
           }
       }.resume()
   }
   
   func fetchMovie(id: Int, successHandler: @escaping (_ response: Movie) -> Void, errorHandler: @escaping(_ error: Error) -> Void) {
       guard let url = URL(string: "\(baseAPIURL)/movie/\(id)?api_key=\(apiKey)&append_to_response=videos,credits") else {
           handleError(errorHandler: errorHandler, error: MovieError.invalidEndpoint)
           return
       }
       
       urlSession.dataTask(with: url) { (data, response, error) in
           guard let data = data else {
               self.handleError(errorHandler: errorHandler, error: MovieError.noData)
               return
           }
           
           do {
               let movie = try self.jsonDecoder.decode(Movie.self, from: data)
               DispatchQueue.main.async {
                   successHandler(movie)
               }
           } catch {
               self.handleError(errorHandler: errorHandler, error: MovieError.serializationError)
           }
       }.resume()
   }
   
   func searchMovie(query: String, params: [String : String]? = nil, successHandler: @escaping (MoviesResponse) -> Void, errorHandler: @escaping (Error) -> Void) {
       
       guard var urlComponents = URLComponents(string: "\(baseAPIURL)/search/movie") else {
           errorHandler(MovieError.invalidEndpoint)
           return
       }
       
       var queryItems = [URLQueryItem(name: "api_key", value: apiKey),
                         URLQueryItem(name: "query", value: query)
                         ]
       if let params = params {
           queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
       }
       
       urlComponents.queryItems = queryItems
       guard let url = urlComponents.url else {
           errorHandler(MovieError.invalidEndpoint)
           return
       }
       
       urlSession.dataTask(with: url) { (data, response, error) in
           guard let data = data else {
               self.handleError(errorHandler: errorHandler, error: MovieError.noData)
               return
           }
           
           do {
               let moviesResponse = try self.jsonDecoder.decode(MoviesResponse.self, from: data)
               DispatchQueue.main.async {
                   successHandler(moviesResponse)
               }
           } catch {
               self.handleError(errorHandler: errorHandler, error: MovieError.serializationError)
           }
           }.resume()
   }
   
    func fetchVideo(id: Int, successHandler: @escaping (_ response: [VideoKey]) -> Void, errorHandler: @escaping(_ error: Error) -> Void) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(id)/videos?api_key=\(apiKey)") else {
            handleError(errorHandler: errorHandler, error: MovieError.invalidEndpoint)
            return
        }
        
        urlSession.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                self.handleError(errorHandler: errorHandler, error: MovieError.noData)
                return
            }
            
            do {
                let video = try self.jsonDecoder.decode(Video.self, from: data)
                DispatchQueue.main.async {
                    successHandler(video.results)
                }
            } catch {
                self.handleError(errorHandler: errorHandler, error: MovieError.serializationError)
            }
        }.resume()
    }
    
   func handleError(errorHandler: @escaping(_ error: Error) -> Void, error: Error) {
       DispatchQueue.main.async {
           errorHandler(error)
       }
   }
}
