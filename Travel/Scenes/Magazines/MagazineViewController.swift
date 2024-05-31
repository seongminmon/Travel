//
//  MagazineViewController.swift
//  Travel
//
//  Created by 김성민 on 5/28/24.
//

import UIKit

class MagazineViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let list = MagazineInfo.magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "TRAVEL"
        
        configureTableView()
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 500
        
        let xib = UINib(nibName: MagazineCell.identifier, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: MagazineCell.identifier)
    }
    
}

extension MagazineViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MagazineCell.identifier, for: indexPath) as! MagazineCell
        
        let magazine = list[indexPath.row]
        cell.configureCell(magazine)
        
        return cell
    }
}
