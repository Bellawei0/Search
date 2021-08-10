//
//  UIView+Extensions.swift
//  Search
//
//  Created by Bella Wei on 8/6/21.
//

import Foundation
import UIKit

extension UIView {
    func applyShadow(withColor color: UIColor = UIColor(red: 82 / 255, green: 97 / 255, blue: 115 / 255, alpha: 1.0), opacity: Float = 1, offset: CGSize = CGSize(width: 0, height: 1), radius: CGFloat = 0) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }

    func roundCorners(radius: CGFloat, corners: UIRectCorner = .allCorners) {
        let cornerRadii = CGSize(width: radius, height: radius)
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: cornerRadii)
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
