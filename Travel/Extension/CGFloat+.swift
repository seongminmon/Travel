//
//  CGFloat+.swift
//  Travel
//
//  Created by 김성민 on 5/28/24.
//

import Foundation

extension CGFloat {
    static var random: CGFloat {
           return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
