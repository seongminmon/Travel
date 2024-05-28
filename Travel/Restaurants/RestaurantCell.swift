//
//  RestaurantCell.swift
//  Travel
//
//  Created by 김성민 on 5/28/24.
//

import UIKit
import Kingfisher

class RestaurantCell: UITableViewCell {
    
    static let identifier = "RestaurantCell"
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var likeButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 10
        
        nameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        categoryLabel.font = .systemFont(ofSize: 16)
        categoryLabel.textAlignment = .right
        
        priceLabel.font = .systemFont(ofSize: 16)
        priceLabel.textColor = .lightGray
        
        phoneNumberLabel.font = .systemFont(ofSize: 16)
        phoneNumberLabel.textColor = .blue
        
        addressLabel.font = .systemFont(ofSize: 16)
        addressLabel.numberOfLines = 2
        
        likeButton.tintColor = .red
    }
    
    func configureCell(_ restaurant: Restaurant) {
        posterImageView.kf.setImage(with: restaurant.imageURL)
        nameLabel.text = restaurant.name
        categoryLabel.text = restaurant.category
        priceLabel.text = restaurant.priceText
        phoneNumberLabel.text = restaurant.phoneNumber
        addressLabel.text = restaurant.address
        likeButton.setImage(restaurant.buttonImage, for: .normal)
    }
    
}
