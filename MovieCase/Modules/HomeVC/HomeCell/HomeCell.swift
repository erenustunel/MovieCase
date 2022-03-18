//
//  HomeCell.swift
//  MovieCase
//
//  Created by Eren Üstünel on 14.03.2022.
//

import UIKit
import Kingfisher

final class HomeCell: UITableViewCell {
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(movie: MovieResponse?) {
        if let title = movie?.title {
            titleLbl.text = title
        }
        if let poster = movie?.poster {
            let url = URL(string: poster)
            imgView.kf.setImage(with: url)
        }
    }
}
