//
//  ServiceList.swift
//  MovieCase
//
//  Created by Eren Üstünel on 14.03.2022.
//

import Foundation

struct MovieServices {
    static let getSearchMovies = "\(Constants.API.baseURL)?apiKey=\(Constants.API.apiKey)&s={0}"
    static let getMoviesWithIMDBId = "\(Constants.API.baseURL)?apiKey=\(Constants.API.apiKey)&i={0}"
}
