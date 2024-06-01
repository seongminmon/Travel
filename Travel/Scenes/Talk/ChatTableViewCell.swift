//
//  ChatTableViewCell.swift
//  Travel
//
//  Created by 김성민 on 6/1/24.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var contentsBackgroundView: UIView!
    @IBOutlet var contentsLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 25
        
        nameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        contentsLabel.font = .systemFont(ofSize: 14)
        contentsLabel.numberOfLines = 0
        
//        contentsBackgroundView.clipsToBounds = true
        contentsBackgroundView.layer.cornerRadius = 8
        contentsBackgroundView.layer.borderWidth = 1
        contentsBackgroundView.layer.borderColor = UIColor.black.cgColor
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .lightGray
    }
    
    func configureCell(_ data: Chat) {
        profileImageView.image = UIImage(named: data.user.profileImage)
        nameLabel.text = data.user.rawValue
        contentsLabel.text = data.message
        dateLabel.text = data.chatDateString
    }
}
