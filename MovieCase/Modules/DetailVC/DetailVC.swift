//
//  DetailVC.swift
//  MovieCase
//
//  Created by Eren Üstünel on 15.03.2022.
//

import UIKit

final class DetailVC: UIViewController {

    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var txtView: UITextView!
    @IBOutlet private weak var imgView: UIImageView!
    @IBOutlet private weak var yearLbl: UILabel!
    @IBOutlet private weak var countryLbl: UILabel!
    @IBOutlet private weak var imdbRateLbl: UILabel!
    
    var vm : DetailVM?

    override func viewDidLoad() {
        super.viewDidLoad()
        vm?.delegate = self
    }
    
    private func setupDetails(movieResponse: MovieResponse?) {
        if let desc = movieResponse?.plot{
            txtView.text = desc
        }
        if let title = movieResponse?.title {
            titleLbl.text = title
        }
        if let img = movieResponse?.poster {
            let url = URL(string: img)
            imgView.kf.setImage(with: url)
        }
        if let year = movieResponse?.year {
            yearLbl.text = year
        }
        if let country = movieResponse?.country {
            countryLbl.text = country
        }
        if let imdbRate = movieResponse?.imdbRating {
            imdbRateLbl.text = imdbRate
        }
    }
}

extension DetailVC: DetailVMDelegate {
    func didGetError(error: String) {
        showAlert(title: error, message: "")
    }
    
    func didGetMovieResponse(movieResponse: MovieResponse?) {
        setupDetails(movieResponse: movieResponse)
    }
}
