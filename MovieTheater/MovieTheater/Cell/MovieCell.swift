//
//  MovieCell.swift
//  MovieTheater
//
//  Created by Map04 on 2021-04-13.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    func configure(_ movie : Movie){
        let url = movie.backdropURL
        let processor = RoundCornerImageProcessor(cornerRadius: 20)
        movieImageView.kf.setImage(with: url, placeholder: nil, options: [.processor(processor)], progressBlock: nil, completionHandler: nil)
    }
}
