//
//  MyChatTableViewCell.swift
//  Travel
//
//  Created by 김성민 on 6/1/24.
//

import UIKit

class MyChatTableViewCell: UITableViewCell {

    @IBOutlet var contentsLabel: UILabel!
    @IBOutlet var contentsBackgroundView: UIView!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        contentsLabel.font = .systemFont(ofSize: 14)
        contentsLabel.numberOfLines = 0
        
        contentsBackgroundView.clipsToBounds = true
        contentsBackgroundView.backgroundColor = .lightGray
        contentsBackgroundView.layer.cornerRadius = 8
        contentsBackgroundView.layer.borderColor = UIColor.black.cgColor
        contentsBackgroundView.layer.borderWidth = 1
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .lightGray
        dateLabel.textAlignment = .right
    }
    
    func configureCell(_ data: Chat) {
        contentsLabel.text = data.message
        dateLabel.text = data.chatDateString
        print(data.chatDateString)
    }
}
