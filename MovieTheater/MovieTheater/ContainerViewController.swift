//
//  ContainerViewController.swift
//  MovieTheater
//
//  Created by Map04 on 2021-04-13.
//

import UIKit

class ContainerViewController: UIViewController {
    @IBOutlet weak var collectionViewController: UICollectionView!
    var myArray =
    [
        ["So far, the FoodTracker app has a single scene, that is, a single screen of content. In a storyboard, each scene contains views managed by that a view controller, and any items added to the controller or its views (for example, Auto Layout constraints). A view is a rectangular region that can draw its own content and respond to user events. Views are instances of the UIView class or one of its subclasses. In this case, the scene contains the view controller’s content view, and all of the subviews you added in Interface Builder (the stack view, label, text field, image view, and rating control).",
         "Taka",
         "Ahmet",
         "Hasan",
         "Li",
         "Lin",
         "Miad",
         "Mihai"],
        ["LuJia",
         "Antony",
         "Bougi",
         "Remon",
         "Now it’s time to create another scene that shows the entire list of meals. Fortunately, iOS comes with a built-in class, UITableView, designed specifically to display a scrolling list of items. A table view is managed by a table view controller (UITableViewController). UITableViewController is a subclass of UIViewController, which is designed to handle table view-related logic. You’ll create the new scene using a table view controller. The controller displays and manages a table view. In fact, the table view is the controller’s content view, and fills the entire space available to the scene.",
         "Carolyn",
         "Andres",
         "Brandon"]
    ]
    var test: String? {
        didSet{
            print("valu recieved from Main VC")
        }
    }
    
    override func viewDidLoad() {
        collectionViewController.delegate = self
        collectionViewController.dataSource = self
        cellSize()
    }
    
    func cellSize(){
        let width = (view.frame.height - 20) / 5
        let flowLayout = collectionViewController.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: width)
    }
}

extension ContainerViewController: UICollectionViewDataSource{
    // 2-1- Number of rows
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return myArray[section].count
    }
    
    // 2-2- Build and return the cell
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath)
        
        if let label = cell.viewWithTag(100) as? UILabel{
            label.text = myArray[indexPath.section][indexPath.row]
        }
        return cell
    }
}
extension ContainerViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}
