//
//  AppServiceClient.swift
//  MovieCase
//
//  Created by Eren Üstünel on 14.03.2022.
//

import Foundation
import Alamofire

class AppServiceClient {
    
    static let shared = AppServiceClient()

    private init () {
    
    }
    
    func getSearchMovie(searchText: String?, completionHandler: @escaping (_ searchMovie: MovieSearchResponse?, _ error: Error?) -> Void)  {
        spinnerStart()
        let serviceURL = MovieServices.getSearchMovies.replace(string: "{0}", replacement: "\(searchText ?? "")")
        AF.request(serviceURL, method: .get,
                   parameters: nil,
                   encoding: URLEncoding(destination: .queryString)).response { (response) in
                    if let data = response.data {
                        do {
                            let movie = try JSONDecoder.init().decode(MovieSearchResponse.self, from: data)
                            completionHandler(movie, nil)
                        } catch {
                            completionHandler(nil, error)
                        }
                    }
                    spinnerStop()
                   }
    }
    
    func getSearchMovieWithIMDBId (imdbId: String,completionHandler: @escaping (_ searchMovie: MovieResponse?, _ error: Error?) -> Void) {
        spinnerStart()
        let serviceURL = MovieServices.getMoviesWithIMDBId.replace(string: "{0}", replacement: "\(imdbId)")
        AF.request(serviceURL, method: .get,
                   parameters: nil,
                   encoding: URLEncoding(destination: .queryString)).response { (response) in
                    if let data = response.data {
                        do {
                            let movie = try JSONDecoder.init().decode(MovieResponse.self, from: data)
                            completionHandler(movie, nil)
                        } catch {
                            completionHandler(nil, error)
                        }
                    }
                   }
        spinnerStop()
    }
    
}
