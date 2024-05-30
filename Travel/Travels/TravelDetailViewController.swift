//
//  TravelDetailViewController.swift
//  Travel
//
//  Created by 김성민 on 5/29/24.
//

import UIKit

class TravelDetailViewController: UIViewController, IdentifierProtocol {
    
    static let identifier = "TravelDetailViewController"
    
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    
    var data: Travel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavi()
        configureUI()
        configureView()
    }
    
    @objc func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    func configureNavi() {
        navigationItem.title = data?.title
        
        let left = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonClicked)
        )
        left.tintColor = .black
        navigationItem.leftBarButtonItem = left
    }
    
    func configureUI() {
        titleLabel.font = .boldSystemFont(ofSize: 16)
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 2
        rateLabel.font = .systemFont(ofSize: 13)
        rateLabel.textColor = .lightGray
        
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.layer.cornerRadius = 10
    }
    
    func configureView() {
        guard let data else { return }
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        rateLabel.text = data.rateText
        mainImageView.kf.setImage(with: data.imageURL)
    }
}
