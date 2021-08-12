//
//  SearchResultCardView.swift
//  Search
//
//  Created by Bella Wei on 8/9/21.
//

import Foundation
import UIKit

class SearchResultCardView: UIView {
    enum Constants {
        static let imageViewFrame = CGRect(x: 0, y: 0, width: 330, height: 305)
        static let titleLabelFrame = CGRect(x: 0, y: 0, width: 290, height: 76)
    }

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.frame = Constants.imageViewFrame
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.frame = Constants.titleLabelFrame
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label

    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.frame = Constants.titleLabelFrame
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label

    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
