//
//  DownloadedMovieTableViewController.swift
//  MovieTheater
//
//  Created by Map04 on 2021-04-13.
//

import UIKit

class DownloadedMovieTableViewController: UITableViewController {
   // var sortedMovies: [Movie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        navigationItem.leftBarButtonItem = UIBarButtonItem (barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
        tableView.reloadData()
        if let savedFavorites = Movie.loadFromFile() {
                favorites = savedFavorites
            }
        print(33333333333)
        print(favorites.count)
    }
    
    @IBAction func sortMoviesByName(_ sender: UIBarButtonItem) {
        favorites.sort {$0.title! < $1.title!}
        tableView.reloadData()
    }
    
    @objc func editButtonTapped (_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let savedFavorites = Movie.loadFromFile() {
//                movies = savedFavorites
//            tableView.reloadData()
//            }
//       // tableView.reloadData()
//        print(666666666)
//        print(movies.count)
        return favorites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.configure(favorites[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "fromDowanloadedToDetail", sender: indexPath)
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else if editingStyle == .insert {
        }
        Movie.saveToFile(favorites)
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedMovie = favorites.remove(at: fromIndexPath.row)
        favorites.insert(movedMovie, at: to.row)
        tableView.reloadData()
        Movie.saveToFile(favorites)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromDowanloadedToDetail" {
            let indexPath = tableView.indexPathForSelectedRow!
            let movie = favorites[indexPath.row]
            let detailTableViewController = segue.destination as! FavoriteDetailTableViewController
            detailTableViewController.movie = movie
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func unwindToDownloadedMovieTableView(_ unwindSegue: UIStoryboardSegue) {
        guard unwindSegue.identifier == "saveUnwind",
              let sourceViewController = unwindSegue.source as? FavoriteDetailTableViewController,
              let movie = sourceViewController.movie else {return}
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            favorites[selectedIndexPath.row] = movie
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else {
            let newIndexPath = IndexPath(row: favorites.count, section: 0)
            favorites.append(movie)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        Movie.saveToFile(favorites)
    }
}
