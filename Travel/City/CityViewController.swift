//
//  CityViewController.swift
//  Travel
//
//  Created by 김성민 on 5/29/24.
//

import UIKit

class CityViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let list: [City] = CityInfo.city
    lazy var selectedList: [City] = list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "인기 도시"
        
        configureTableView()
    }

    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 120
        tableView.separatorStyle = .none
        
        let xib = UINib(nibName: CityCell.identifier, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: CityCell.identifier)
    }
}

extension CityViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.identifier, for: indexPath) as! CityCell
        
        let data = selectedList[indexPath.row]
        cell.configureCell(data: data)
        
        cell.selectionStyle = .none
        return cell
    }
}