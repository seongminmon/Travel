//
//  ReuseIdentifierProtocol.swift
//  Travel
//
//  Created by 김성민 on 5/30/24.
//

import UIKit

protocol ReuseIdentifierProtocol {
    static var identifier: String { get }
}

extension UIViewController: ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
