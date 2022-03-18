//
//  HomeVM.swift
//  MovieCase
//
//  Created by appcent on 14.03.2022.
//

import Foundation
import Kingfisher

protocol HomeVMDelegate: AnyObject{
    func didGetMoviesResponse(movie: MovieSearchResponse)
}

class HomeVM {
    weak var delegate: HomeVMDelegate?
    
    func getSearchMovie(searchText: String?) {
        AppServiceClient.shared.getSearchMovie(searchText: searchText ?? "") { (response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }else {
                self.delegate?.didGetMoviesResponse(movie: response ?? MovieSearchResponse(Search: []))
            }
        }
    }
    
    
    func getPosters() {
        
    }
}
