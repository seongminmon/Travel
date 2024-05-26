//
//  RestaurantTableViewController.swift
//  Travel
//
//  Created by 김성민 on 5/26/24.
//

import UIKit
import Kingfisher

class RestaurantTableViewController: UITableViewController {
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    let list = RestaurantList().restaurantArray
    
    var likeList: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 150
        
        likeList = [Bool](repeating: false, count: list.count)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        
        let restaurant = list[indexPath.row]
        
        let url = URL(string: restaurant.image)
        cell.posterImageView.kf.setImage(with: url)
        cell.posterImageView.contentMode = .scaleAspectFill
        cell.posterImageView.layer.cornerRadius = 10
        
        cell.nameLabel.text = restaurant.name
        cell.nameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        cell.categoryLabel.text = restaurant.category
        cell.categoryLabel.font = .systemFont(ofSize: 16)
        cell.categoryLabel.textAlignment = .right
//        cell.categoryLabel.textColor = .lightGray
        
        cell.priceLabel.text = restaurant.price.formatted() + "원"
        cell.priceLabel.font = .systemFont(ofSize: 16)
        cell.priceLabel.textColor = .lightGray
        
        cell.phoneNumberLabel.text = restaurant.phoneNumber
        cell.phoneNumberLabel.font = .systemFont(ofSize: 16)
//        cell.phoneNumberLabel.textColor = .lightGray
        
        cell.addressLabel.text = restaurant.address
        cell.addressLabel.font = .systemFont(ofSize: 16)
        cell.addressLabel.numberOfLines = 2
        
        
        let image = likeList[indexPath.row] ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        cell.likeButton.setImage(image, for: .normal)
        cell.likeButton.tintColor = .red
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        cell.likeButton.tag = indexPath.row
        
        return cell
    }
    
    @objc func likeButtonTapped(sender: UIButton) {
        likeList[sender.tag].toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
}
