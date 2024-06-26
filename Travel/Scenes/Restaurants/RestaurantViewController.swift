//
//  RestaurantViewController.swift
//  Travel
//
//  Created by 김성민 on 5/28/24.
//

import UIKit

class RestaurantViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var firstFilterButton: UIButton!
    @IBOutlet var secondFilterButton: UIButton!
    @IBOutlet var thirdFilterButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    lazy var buttonList: [UIButton] = [
        firstFilterButton,
        secondFilterButton,
        thirdFilterButton
    ]
    
    let total = RestaurantList.restaurantArray
    var list = RestaurantList.restaurantArray {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "식당 검색"
        
        searchBar.delegate = self
        
        firstFilterButton.setTitle("전체", for: .normal)
        secondFilterButton.setTitle("한식", for: .normal)
        thirdFilterButton.setTitle("만원 이하", for: .normal)
        buttonList.forEach {
            configureButton($0)
        }
        
        firstFilterButton.addTarget(self, action: #selector(firstFilterButtonTapped), for: .touchUpInside)
        secondFilterButton.addTarget(self, action: #selector(secondFilterButtonTapped), for: .touchUpInside)
        thirdFilterButton.addTarget(self, action: #selector(thirdFilterButtonTapped), for: .touchUpInside)
        
        configureTableView()
    }
    
    @objc func firstFilterButtonTapped() {
        list = total
        view.endEditing(true)
    }
    
    @objc func secondFilterButtonTapped() {
        list = total.filter { $0.category == "한식" }
        view.endEditing(true)
    }
    
    @objc func thirdFilterButtonTapped() {
        list = total.filter { $0.price <= 10000 }
        view.endEditing(true)
    }
    
    func configureButton(_ button: UIButton) {
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 15
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 120
        tableView.keyboardDismissMode = .onDrag
        
        let xib = UINib(nibName: RestaurantCell.identifier, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: RestaurantCell.identifier)
    }
    
    // 다른 화면 터치 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension RestaurantViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantCell.identifier, for: indexPath) as! RestaurantCell
        
        let restaurant = list[indexPath.row]
        cell.configureCell(restaurant)
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        cell.selectionStyle = .none
        return cell
    }
    
    @objc func likeButtonTapped(sender: UIButton) {
        list[sender.tag].like.toggle()
    }
}

extension RestaurantViewController: UISearchBarDelegate {
    
    // 실시간 검색
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        list = total.filter { $0.name.contains(searchText) }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 키보드 내리기
        searchBar.resignFirstResponder()
    }
}
