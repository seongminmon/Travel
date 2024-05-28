//
//  MagazineCell.swift
//  Travel
//
//  Created by 김성민 on 5/28/24.
//

import UIKit
import Kingfisher

class MagazineCell: UITableViewCell {
    
    static let identifier = "MagazineCell"
    
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    func configureUI() {
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.layer.cornerRadius = 20
        
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.numberOfLines = 0
        
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.textColor = .lightGray
        
        dateLabel.font = .systemFont(ofSize: 16)
        dateLabel.textColor = .lightGray
        dateLabel.textAlignment = .right
    }
    
    func configureCell(_ magazine: Magazine) {
        let url = URL(string: magazine.photo_image)
        mainImageView.kf.setImage(with: url)
        titleLabel.text = magazine.title
        descriptionLabel.text = magazine.subtitle
        dateLabel.text = magazine.dateString
    }
    
}
