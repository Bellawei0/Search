//
//  CardShadowProvider.swift
//  Search
//
//  Created by Bella Wei on 8/6/21.
//

import UIKit

public protocol ShadowProvider {
    var shadowView: UIView { get }
    func applyCardShadow()
}

public extension ShadowProvider where Self: UIView {
    var containerView: UIView { return self }

    func applyCardShadow() {
        backgroundColor = UIColor.clear
        shadowView.layer.backgroundColor = UIColor.white.cgColor
        shadowView.layer.cornerRadius = 8
        shadowView.layer.masksToBounds = true
        shadowView.superview?.applyShadow(opacity: 0.5, radius: 20)
    }
}

public extension ShadowProvider where Self: UICollectionViewCell {
    var containerView: UIView { return contentView }
}
