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
    
    let list: [Travel] = TravelInfo().travel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 120
        
        let travelCell = UINib(nibName: "TravelTableViewCell", bundle: nil)
        tableView.register(travelCell, forCellReuseIdentifier: "TravelTableViewCell")
        let adCell = UINib(nibName: "AdTableViewCell", bundle: nil)
        tableView.register(adCell, forCellReuseIdentifier: "AdTableViewCell")
    }
}

extension TravelViewController: UITableViewDataSource {
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
            
            cell.configure(data: data.title)
            
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "TravelTableViewCell",
                for: indexPath
            ) as! TravelTableViewCell
            
            cell.configure(data: data)
            
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension TravelViewController: UITableViewDelegate {
    
}
