//
//  ImageCollectionViewCell.swift
//  PhotoSearch
//
//  Created by Bella Wei on 8/2/21.
//

import Foundation
import SDWebImage
import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    enum Constants {
        static let indentifier = "ImageCollectionViewCell"
        static let imageHeight: CGFloat = 300
        static let labelPadding: CGFloat = 5
        static let leftPadding: CGFloat = 10
        static let bottomPadding: CGFloat = 20
        static let dateLabelSize: CGFloat = 15
        static let titleLabelSize: CGFloat = 18
        static let numberOfLine = 1
    }

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.clipsToBounds = true
        return view
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.numberOfLines = Constants.numberOfLine
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label

    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = Constants.numberOfLine
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label

    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()

        applyShadow(opacity: 0.5, radius: 8)
        contentView.roundCorners(radius: 20)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = ""
        dateLabel.text = ""
    }

    func configure(with viewModel: SearchViewModel) {
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.createDate

        guard let url = URL(string: viewModel.thumbnailUrl!) else { return }
        imageView.sd_setImage(with: url, completed: nil)
    }

    private func setupView() {
        contentView.addSubview(containerView)
        [titleLabel, dateLabel, imageView].forEach { containerView.addSubview($0) }
        [containerView, titleLabel, dateLabel, imageView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.labelPadding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.leftPadding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),

            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.labelPadding),
            dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.leftPadding),
            dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constants.bottomPadding),
        ])
    }
}
