//
//  UIBarButtonItem+Badge.swift
//  OrderPlacementApp
//
//  Created by A1VNCFUR on 15/09/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    
    private struct Constant {
        static let badgeSize:CGFloat = 20.0
        static let badgeBorderWidth:CGFloat = 20.0
        static let badgeFontSize:CGFloat = 13.0
        static let badgeLabelTag = 1001
        
        static let viewKey = "view"
    }
    
    func addBadge() {
        guard let view = value(forKey: Constant.viewKey) as? UIView else {
            return
        }
        let badgeLabel = view.viewWithTag(Constant.badgeLabelTag) as? UILabel
        
        if badgeLabel != nil {
            return
        }
        let frame = CGRect(x: view.frame.size.width - Constant.badgeSize, y: 0, width: Constant.badgeSize, height: Constant.badgeSize)
        let label = createBadgeLabel(withFrame: frame)
        
        view.addSubview(label)
    }
    
    func updateBadgecount(count:Int) {
        guard let view = value(forKey: Constant.viewKey) as? UIView else {
            return
        }
        if let label = view.viewWithTag(Constant.badgeLabelTag) as? UILabel {
            if count > 9 {
                label.text = "9+"
            } else {
                label.text = "\(count)"
            }
        }
    }
    
    private func createBadgeLabel(withFrame frame: CGRect) -> UILabel {
        let label = UILabel(frame: frame)
        label.layer.borderColor = UIColor.clear.cgColor
        label.layer.borderWidth = Constant.badgeBorderWidth
        label.layer.cornerRadius = label.bounds.size.height / 2
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.font = UIFont.systemFont(ofSize: Constant.badgeFontSize)
        label.textColor = .white
        label.backgroundColor = .red
        label.text = "0"
        label.tag = Constant.badgeLabelTag
        
        return label
    }
}
