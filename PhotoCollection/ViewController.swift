//
//  ViewController.swift
//  PhotoCollection
//
//  Created by Connor Dear on 2017-04-21.
//  Copyright © 2017 Connor Dear. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var photos : [Photo] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let photoForCurrentCell = photos[indexPath.row]
        cell.textLabel?.text = photoForCurrentCell.title
        cell.imageView?.image = UIImage(data: photoForCurrentCell.photo as! Data)
        return cell
    }
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            photos = try context.fetch(Photo.fetchRequest())
            print(photos)
        } catch {
            print("There was an error fetching the photo data")
        }
        tableView.reloadData()
    }


}

