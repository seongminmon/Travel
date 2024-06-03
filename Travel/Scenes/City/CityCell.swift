//
//  CityCell.swift
//  Travel
//
//  Created by 김성민 on 5/29/24.
//

import UIKit
import Kingfisher

class CityCell: UITableViewCell {

    @IBOutlet var shadowView: UIView!
    @IBOutlet var imageBackView: UIView!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        // 그림자 설정
        shadowView.backgroundColor = .clear
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowRadius = 20
        shadowView.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        imageBackView.clipsToBounds = true
        imageBackView.layer.cornerRadius = 20
        imageBackView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        
        mainImageView.contentMode = .scaleAspectFill
        
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .white
        
        backView.backgroundColor = .black
        backView.layer.opacity = 0.7
        
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.textColor = .white
    }
    
    func configureCell(data: City) {
        mainImageView.kf.setImage(with: data.imageURL)
        titleLabel.text = data.totalCityName
        descriptionLabel.text = data.city_explain
    }
}
