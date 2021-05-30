//
//  FavoriteDetailTableViewController.swift
//  MovieTheater
//
//  Created by Map04 on 2021-05-27.
//

import UIKit
import Kingfisher
import SafariServices
import WebKit

class FavoriteDetailTableViewController: UITableViewController {

    var movie: Movie?
    var videoKey: VideoKey?
    var movieViewModel = MovieViewModel ()
    var movieIndex: Int?

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameTextField: UITextField!
    @IBOutlet weak var movieOverrviewTextView: UITextView!
    @IBOutlet weak var releaseDateTextField: UITextField!
    @IBOutlet weak var trailerWebView: WKWebView!
    
    let imageViewIndexPath = IndexPath(row: 0, section: 0)
    let overViewIndexPath = IndexPath(row: 1, section: 1)
    let titleIndexPath = IndexPath(row: 0, section: 1)
    let normalCellHeight: CGFloat = 44
    let largeCellHeight: CGFloat = 200
    var isMovieOverviewHidden: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        movieViewModel.loadVideo(id: movie!.id!) { [self] in
            let myURL = URL(string: "https://www.youtube.com/embed/\(movieViewModel.videoKeys.first!.key)")
            let youtubeRequest = URLRequest(url: myURL!)
            self.trailerWebView.load(youtubeRequest)
        }
        movieNameTextField.text = movie!.title
        movieOverrviewTextView.text = movie!.overview
        releaseDateTextField.text = movie!.releaseDate
        let processor = RoundCornerImageProcessor(cornerRadius: 20)
        movieImageView.kf.setImage(with: movie!.backdropURL, placeholder: nil, options: [.processor(processor)], progressBlock: nil, completionHandler: nil)
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        guard let image = movieImageView.image else { return }
        let activityController = UIActivityViewController(activityItems: [image],
                                                          applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender
        present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func safariButtonTapped(_ sender: Any) {
        if let url = URL(string: "https://www.youtube.com/embed/\(movieViewModel.videoKeys.first!.key)") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .yellow
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveUnwind" else { return }
        movie?.title = movieNameTextField.text ?? ""
        movie?.overview = movieOverrviewTextView.text ?? ""
        movie?.releaseDate = releaseDateTextField.text ?? ""
    }
}
