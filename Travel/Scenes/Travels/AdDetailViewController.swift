//
//  AdDetailViewController.swift
//  Travel
//
//  Created by 김성민 on 5/29/24.
//

import UIKit

class AdDetailViewController: UIViewController {

    @IBOutlet var mainLabel: UILabel!
    
    var data: Travel?
    
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
        
        mainLabel.text = data?.title
        mainLabel.numberOfLines = 0
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
}
