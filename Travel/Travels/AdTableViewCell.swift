//
//  AdTableViewCell.swift
//  Travel
//
//  Created by 김성민 on 5/27/24.
//

import UIKit

class AdTableViewCell: UITableViewCell {

    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var markLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        mainLabel.font = .systemFont(ofSize: 18, weight: .bold)
        mainLabel.numberOfLines = 0
        
        markLabel.font = .systemFont(ofSize: 16)
        markLabel.textAlignment = .center
        markLabel.textColor = .black
        markLabel.backgroundColor = .white
        markLabel.clipsToBounds = true
        markLabel.layer.cornerRadius = 5
        
        contentView.layer.cornerRadius = 18
    }
    
    func configure(data: String) {
        mainLabel.text = data
        markLabel.text = "AD"
        
        let colors: [UIColor] = [.systemTeal, .systemBlue, .systemBrown, .systemOrange, .systemIndigo]
        contentView.backgroundColor = colors.randomElement()!
    }

}
