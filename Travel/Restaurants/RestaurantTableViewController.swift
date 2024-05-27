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
    
    @IBOutlet var allButton: UIButton!
    @IBOutlet var koreanButton: UIButton!
    @IBOutlet var cheaperButton: UIButton!
    
    let list = RestaurantList().restaurantArray
    var filteredList: [Restaurant] = []
    var likeList: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 150
        
        filteredList = list
        likeList = [Bool](repeating: false, count: list.count)
        
        searchTextField.placeholder = "가게 이름을 검색해보세요"
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        configureButton(button: allButton)
        configureButton(button: koreanButton)
        configureButton(button: cheaperButton)
        
        allButton.addTarget(self, action: #selector(allButtonTapped), for: .touchUpInside)
        koreanButton.addTarget(self, action: #selector(koreanButtonTapped), for: .touchUpInside)
        cheaperButton.addTarget(self, action: #selector(cheaperButtonTapped), for: .touchUpInside)
    }
    
    func configureButton(button: UIButton) {
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 20
    }
    
    @objc func searchButtonTapped() {
        guard let keyword = searchTextField.text, keyword != "" else { return }
        
        // 검색
        filteredList = list.filter {
            $0.name.contains(keyword) ||
            $0.category.contains(keyword) ||
            $0.address.contains(keyword)
        }
        // 테이블뷰 갱신
        tableView.reloadData()
        // 키보드 내리기
        view.endEditing(true)
    }
    
    @objc func allButtonTapped() {
        filteredList = list
        tableView.reloadData()
    }
    
    @objc func koreanButtonTapped() {
        filteredList = list.filter { $0.category == "한식" }
        tableView.reloadData()
    }
    
    @objc func cheaperButtonTapped() {
        filteredList = list.filter { $0.price <= 10_000 }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        
        let restaurant = filteredList[indexPath.row]
        
        let url = URL(string: restaurant.image)
        cell.posterImageView.kf.setImage(with: url)
        cell.posterImageView.contentMode = .scaleAspectFill
        cell.posterImageView.layer.cornerRadius = 10
        
        cell.nameLabel.text = restaurant.name
        cell.nameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        cell.categoryLabel.text = restaurant.category
        cell.categoryLabel.font = .systemFont(ofSize: 16)
        cell.categoryLabel.textAlignment = .right
        
        cell.priceLabel.text = restaurant.price.formatted() + "원"
        cell.priceLabel.font = .systemFont(ofSize: 16)
        cell.priceLabel.textColor = .lightGray
        
        cell.phoneNumberLabel.text = restaurant.phoneNumber
        cell.phoneNumberLabel.font = .systemFont(ofSize: 16)
        
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
