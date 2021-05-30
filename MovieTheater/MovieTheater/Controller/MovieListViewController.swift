//
//  ViewController.swift
//  MovieTheater
//
//  Created by Map04 on 2021-04-12.
//

import UIKit

class MovieListViewController: UIViewController {
    var movieViewModel = MovieViewModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterSegment: UISegmentedControl!
    let queryOptions = ["now_playing", "upcoming", "popular", "top_rated"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        movieViewModel.loadMovies (from: "now_playing") {
            self.tableView.reloadData()
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }

    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        let filterType = queryOptions[sender.selectedSegmentIndex]
        movieViewModel.loadMovies (from: filterType) {
            self.tableView.reloadData()
        }
    }
    
    @objc func editButtonTapped (_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieViewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.configure(movieViewModel.movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: indexPath)
        movieViewModel.updateMovieIndex(indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let indexPath = tableView.indexPathForSelectedRow!
            let movie = movieViewModel.movies[indexPath.row]
            let detailTableViewController = segue.destination as! DetailTableViewController
            detailTableViewController.movie = movie
            detailTableViewController.movieIndex = indexPath.row
        }
    }
}


