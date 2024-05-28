//
//  TravelViewController.swift
//  Travel
//
//  Created by 김성민 on 5/27/24.
//

import UIKit
import Kingfisher

class TravelViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var list: [Travel] = TravelInfo.travel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "도시 상세 정보"
        
        configureTableView()
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        let travelCell = UINib(nibName: "TravelTableViewCell", bundle: nil)
        tableView.register(travelCell, forCellReuseIdentifier: "TravelTableViewCell")
        let adCell = UINib(nibName: "AdTableViewCell", bundle: nil)
        tableView.register(adCell, forCellReuseIdentifier: "AdTableViewCell")
    }
}

extension TravelViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return list[indexPath.row].ad ? UITableView.automaticDimension : 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = list[indexPath.row]
        
        if data.ad {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "AdTableViewCell",
                for: indexPath
            ) as! AdTableViewCell
            
            cell.configureCell(data: data.title)
            
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "TravelTableViewCell",
                for: indexPath
            ) as! TravelTableViewCell
            
            cell.configureCell(data: data)
            cell.likeButton.addTarget(
                self,
                action: #selector(likeButtonTapped),
                for: .touchUpInside
            )
            cell.likeButton.tag = indexPath.row
            
            cell.selectionStyle = .none
            return cell
        }
    }
    
    @objc func likeButtonTapped(sender: UIButton) {
        list[sender.tag].like?.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
}

extension TravelViewController: UITableViewDelegate {
    
}
