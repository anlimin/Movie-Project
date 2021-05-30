//
//  MovieSearchViewController.swift
//  MovieTheater
//
//  Created by Map04 on 2021-04-13.
//

import UIKit

class MovieSearchViewController: UIViewController {
    var movieViewModel = MovieViewModel()
    var movie: Movie?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        setupNavigationBar()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        let searchBar = self.navigationItem.searchController!.searchBar
        searchBar.delegate = self
    }
    
    func setupNavigationBar() {
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        self.definesPresentationContext = true
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController?.searchBar.sizeToFit()
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension MovieSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieViewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.configure(movieViewModel.movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "fromSearchToDetail", sender: indexPath)
        print(indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromSearchToDetail" {
            let indexPath = tableView.indexPathForSelectedRow!
            let movie = movieViewModel.movies[indexPath.row]
            let detailTableViewController = segue.destination as! DetailTableViewController
            detailTableViewController.movie = movie
        }
    }
}

extension MovieSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        movieViewModel.searchMovie(from: searchBar.text!) {
            self.tableView.reloadData()
        }
        searchBar.resignFirstResponder()
    }
}
