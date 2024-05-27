//
//  TravelTableViewCell.swift
//  Travel
//
//  Created by 김성민 on 5/27/24.
//

import UIKit

class TravelTableViewCell: UITableViewCell {

    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        titleLabel.font = .boldSystemFont(ofSize: 16)
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 2
        rateLabel.font = .systemFont(ofSize: 13)
        rateLabel.textColor = .lightGray
        
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.layer.cornerRadius = 10
        likeButton.tintColor = .white
    }
    
    func configure(data: Travel) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        rateLabel.text = "⭐️ \(data.grade!) · 저장 \(data.save!.formatted())"
        
        let url = URL(string: data.travel_image!)
        mainImageView.kf.setImage(with: url)
        
        let buttonImage = data.like! ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        likeButton.setImage(buttonImage, for: .normal)
    }
}
