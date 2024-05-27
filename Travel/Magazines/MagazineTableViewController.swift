//
//  MagazineTableViewController.swift
//  Travel
//
//  Created by 김성민 on 5/25/24.
//

import UIKit
import Kingfisher

class MagazineTableViewController: UITableViewController {

    let list = MagazineInfo().magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "SeSAC TRAVEL"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MagazineTableViewCell", for: indexPath) as! MagazineTableViewCell
        
        let magazine = list[indexPath.row]
        
        let url = URL(string: magazine.photo_image)
        cell.photoImageView.kf.setImage(with: url)
        cell.photoImageView.contentMode = .scaleAspectFill
        cell.photoImageView.layer.cornerRadius = 20
        
        cell.titleLabel.text = magazine.title
        cell.titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        cell.titleLabel.numberOfLines = 0
        
        cell.subtitleLabel.text = magazine.subtitle
        cell.subtitleLabel.font = .systemFont(ofSize: 16)
        cell.subtitleLabel.textColor = .lightGray
        
        cell.dateLabel.text = magazine.dateString
        cell.dateLabel.font = .systemFont(ofSize: 16)
        cell.dateLabel.textColor = .lightGray
        cell.dateLabel.textAlignment = .right
        
        cell.selectionStyle = .none
        
        return cell
    }
}
