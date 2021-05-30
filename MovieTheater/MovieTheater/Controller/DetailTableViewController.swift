//
//  DetailTableViewController.swift
//  MovieTheater
//
//  Created by Map04 on 2021-04-13.
//

import UIKit
import Kingfisher
import SafariServices
import WebKit

class DetailTableViewController: UITableViewController {
    var movie: Movie?
    var videoKey: VideoKey?
    var faroviteMovie = [Movie]()
    var movieViewModel = MovieViewModel ()
    var movieIndex: Int?
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var trailerWebView: WKWebView!
    let imageViewIndexPath = IndexPath(row: 0, section: 0)
    let overViewIndexPath = IndexPath(row: 1, section: 1)
    let titleIndexPath = IndexPath(row: 0, section: 1)
    let normalCellHeight: CGFloat = 44
    let largeCellHeight: CGFloat = 200
    var isMovieOverviewHidden: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        movieViewModel.loadVideo(id: movie!.id!){ [self] in
            let myURL = URL(string: "https://www.youtube.com/embed/\(movieViewModel.videoKeys.first!.key)")
            let youtubeRequest = URLRequest(url: myURL!)
            self.trailerWebView.load(youtubeRequest)
        }
        movieTitle.text = movie!.title
        movieOverviewLabel.text = movie!.overview
        let processor = RoundCornerImageProcessor(cornerRadius: 20)
        movieImageView.kf.setImage(with: movie!.backdropURL, placeholder: nil, options: [.processor(processor)], progressBlock: nil, completionHandler: nil)
        checkIsFavorite()
    }
    
    @IBAction func favoriteBarButtonPressed(_ sender: UIBarButtonItem) {
        favorites = Movie.loadFromFile() ?? [Movie]()
        if sender.image == UIImage(systemName: "star"){
            favorites.append(movie!)
            print(movie!.title!)
            Movie.saveToFile(favorites)
            favoriteButton!.image = UIImage(systemName: "star.fill")
        }else if sender.image == UIImage(systemName: "star.fill") {
            for element in favorites {
                if element.title == movieTitle.text{
                    if let index = favorites.firstIndex(of: element) {
                        favorites.remove(at: index)
                        Movie.saveToFile(favorites)
                        favoriteButton.image = UIImage(systemName: "star")
                    }
                }
            }
        }
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == titleIndexPath {
            isMovieOverviewHidden.toggle()
            movieTitle.textColor = isMovieOverviewHidden ? .black : tableView.tintColor
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case overViewIndexPath:
            return isMovieOverviewHidden ? 0 : largeCellHeight
        case imageViewIndexPath:
            return largeCellHeight
        default:
            return normalCellHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .yellow
    }
    
    func checkIsFavorite() {
        if Movie.loadFromFile() != nil {
            for element in Movie.loadFromFile()! {
                print(element.title!)
                print(movieTitle.text!)
                if element.title == movieTitle.text{
                    print(movieTitle.text!)
                    print(element.title!)
                    favoriteButton.image = UIImage(systemName: "star.fill")
                    print(favoriteButton.image!)
                }
            }
        }
    }
}
