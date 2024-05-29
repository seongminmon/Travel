//
//  TravelDetailViewController.swift
//  Travel
//
//  Created by 김성민 on 5/29/24.
//

import UIKit

class TravelDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "관광지 화면"
        
        let left = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonClicked)
        )
        left.tintColor = .black
        navigationItem.leftBarButtonItem = left
    }
    
    @objc func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
}
