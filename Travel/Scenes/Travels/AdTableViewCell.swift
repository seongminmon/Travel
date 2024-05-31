//
//  AdTableViewCell.swift
//  Travel
//
//  Created by 김성민 on 5/27/24.
//

import UIKit

class AdTableViewCell: UITableViewCell {

    @IBOutlet var backView: UIView!
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var markLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configureUI() {
        print(#function)
        
        mainLabel.font = .systemFont(ofSize: 18, weight: .bold)
        mainLabel.textAlignment = .center
        mainLabel.numberOfLines = 0
        
        markLabel.font = .systemFont(ofSize: 16)
        markLabel.textAlignment = .center
        markLabel.textColor = .black
        markLabel.backgroundColor = .white
        markLabel.clipsToBounds = true
        markLabel.layer.cornerRadius = 5
        
        markLabel.text = "AD"
        
        backView.layer.cornerRadius = 20
        // TODO: - 셀을 탭하고 디테일뷰에 갔다왔을 때 색깔이 달라지는 문제 해결하기
        backView.backgroundColor = .random
    }
    
    func configureCell(data: String) {
        mainLabel.text = data
    }
}
