//
//  AdDetailViewController.swift
//  Travel
//
//  Created by 김성민 on 5/29/24.
//

import UIKit

class AdDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "광고 화면"
        
        let left = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(closeButtonClicked)
        )
        left.tintColor = .black
        navigationItem.leftBarButtonItem = left
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
    
}
