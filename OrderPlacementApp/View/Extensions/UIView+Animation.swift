//
//  UIView+Animation.swift
//  OrderPlacementApp
//
//  Created by Mithilesh on 14/09/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    private struct Constants {
        static let zoomAnimationTime = 0.3
        static let moveAnimationTime = 0.6
        static let delayAnimationTime = 0.0
        
        static let zoomScale:CGFloat = 1.2
        static let moveScale:CGFloat = 0.1
        
        static let minAlpha:CGFloat = 0.4
    }
    
    func applyAddToCartAnimation(parentView: UIView, to centerPoint: CGPoint, _ completion: @escaping (() -> Void)) {
        parentView.addSubview(self)
        applyZoomAnimation {[weak self] in
            self?.applyMoveAnimation(centerPoint: centerPoint, {
                self?.removeFromSuperview()
                completion()
            })
        }
    }
    
    //MARK : private methods
    
    private func applyZoomAnimation(_ completion: @escaping (() -> Void)) {
        UIView.animate(withDuration: Constants.zoomAnimationTime, delay: Constants.delayAnimationTime, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: Constants.zoomScale, y: Constants.zoomScale)
        }, completion: { (complete) in
            completion()
        })
    }
    
    private func applyMoveAnimation(centerPoint: CGPoint, _ completion: @escaping (() -> Void)) {
        UIView.animate(withDuration: Constants.moveAnimationTime, delay: Constants.delayAnimationTime, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: Constants.moveScale, y: Constants.moveScale)
            self.alpha = Constants.minAlpha
            self.center = centerPoint
        }) { (complete) in
            completion()
        }
    }
}
