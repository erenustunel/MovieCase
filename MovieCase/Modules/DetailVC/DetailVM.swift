//
//  DetailVM.swift
//  MovieCase
//
//  Created by Eren Üstünel on 15.03.2022.
//

import Foundation
import FirebaseAnalytics

protocol DetailVMDelegate: AnyObject {
    func didGetMovieResponse(movieResponse: MovieResponse?)
    func didGetError(error: String)
}

class DetailVM {
    weak var delegate: DetailVMDelegate?
    
    var imdbId: String?
    
    init(imdbId: String) {
        if imdbId != "" {
            self.imdbId = imdbId
            getMovieWithIMDBId(imdbId: imdbId)
        }
    }
    
    private func getMovieWithIMDBId(imdbId: String?) {
        AppServiceClient.shared.getSearchMovieWithIMDBId(imdbId: imdbId ?? "" ) { (response, error) in
            if let error = error {
                print(error.localizedDescription)
                self.delegate?.didGetError(error: error.localizedDescription)
                return
            }else {
                self.delegate?.didGetMovieResponse(movieResponse: response)
                Analytics.logEvent("movieDetail", parameters: try! response?.asDictionary())
            }
        }
    }
}
