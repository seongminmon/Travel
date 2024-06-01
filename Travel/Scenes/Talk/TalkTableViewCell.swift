//
//  TalkTableViewCell.swift
//  Travel
//
//  Created by 김성민 on 6/1/24.
//

import UIKit

class TalkTableViewCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var contentsLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
//        profileImageView.backgroundColor = .gray
        nameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        contentsLabel.font = .systemFont(ofSize: 14)
        contentsLabel.textColor = .lightGray
        dateLabel.font = .systemFont(ofSize: 13)
        dateLabel.textColor = .lightGray
        dateLabel.textAlignment = .right
    }
    
    func configureCell(_ data: ChatRoom) {
        let imageName = data.chatroomImage.first ?? ""
        profileImageView.image = UIImage(named: imageName)
        nameLabel.text = data.chatroomName
        contentsLabel.text = data.chatList.last?.message
        dateLabel.text = data.chatList.last?.talkDateString
    }
}
