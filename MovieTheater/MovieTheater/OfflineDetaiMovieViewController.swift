//
//  OfflineDetaiMovieViewController.swift
//  MovieTheater
//
//  Created by Map04 on 2021-04-14.
//

import UIKit
import Kingfisher

class OfflineDetailMovieViewController: UIViewController {
    var movie: Movie?
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var releaseDateTextField: UITextField!
    @IBOutlet weak var ratingTextField: UITextField!
    
//    override func viewDidLoad() {
//        view.backgroundColor = .black
//        if let movie = movie {
//            titleTextField.text = movie.title
//            overviewTextView.text = movie.overview
//        
//            releaseDateTextField.text = movie.releaseDate
//            
//            let processor = RoundCornerImageProcessor(cornerRadius: 20)
//            print(movie.posterURL)
//            movieImageView.kf.setImage(with: movie.posterURL, placeholder: nil, options: [.onlyFromCache,.processor(processor)], progressBlock: nil, completionHandler: nil)
//        }
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == "saveUnwind" else {return}
//        let title = titleTextField.text ?? ""
//        let id = Int(idTextField.text!) ?? 0
//        let posterPath = posterPathTextField.text ?? ""
//        let backdropPath = backdropPathTextField.text ?? ""
//        let releaseDate = releaseDateTextField.text ?? ""
//        let rating = Double(ratingTextField.text!) ?? 0.0
//        let overview = overviewTextView.text ?? ""
//        movie = Movie(id: id, posterPath: posterPath, backdropPath: backdropPath, title: title, releaseDate: releaseDate, rating: rating, overview: overview)
//    }
    
    

}
