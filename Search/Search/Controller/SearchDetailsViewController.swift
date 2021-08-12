//
//  SearchDetailsViewController.swift
//  Search
//
//  Created by Bella Wei on 8/6/21.
//

import Foundation
import SDWebImage
import UIKit

class SearchDetailsViewController: UIViewController {
    enum Constants {
        static let imageHeight: CGFloat = 300
        static let imageWidth = UIScreen.main.bounds.width
        static let titleTopPadding: CGFloat = 10
        static let leftPadding: CGFloat = 16
        static let rightPadding: CGFloat = -16
        static let attributedStringValue = 0.24
        static let lineHeightMultipler: CGFloat = 1.22
        static let titleLabelFont = UIFont(name: "Roboto-Bold", size: 18)
        static let titleLabelBoldSize: CGFloat = 18
        static let dateLabelFont = UIFont(name: "Roboto-Medium", size: 14)
        static let descriptionLabelFont = UIFont(name: "Roboto-Regular", size: 14)
        static let scrollViewheight: CGFloat = 800
        static let scrollContentSize: CGFloat = 400
    }

    private var viewModel: SearchViewModel

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.frame = CGRect(x: 0, y: 0, width: Constants.imageWidth, height: Constants.scrollViewheight)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.bounces = true
        scrollView.contentSize = CGSize(width: Constants.imageWidth, height: Constants.imageHeight + Constants.scrollContentSize)
        return scrollView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = Constants.dateLabelFont
        return dateLabel

    }()

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = Constants.titleLabelFont
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.titleLabelBoldSize)
        return titleLabel
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.descriptionLabelFont
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(dismissSelf))
        view.backgroundColor = .systemBackground
        setupView()
        configure()
        setupConstraints()
    }

    private func setupView() {
        [scrollView, imageView, dateLabel, titleLabel, descriptionLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        view.addSubview(scrollView)
        [imageView, dateLabel, titleLabel, descriptionLabel].forEach { scrollView.addSubview($0) }
    }

    private func configure() {
        if let thumbnailUrl = viewModel.thumbnailUrl {
            let url = URL(string: thumbnailUrl)
            imageView.sd_setImage(with: url, completed: nil)
        }

        dateLabel.text = viewModel.createDate
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        descriptionLabel.attributedText = setBodyTextAttribute(viewModel.description)
    }

    private func setBodyTextAttribute(_ string: String) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.kern: Constants.attributedStringValue,
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
        ]
        paragraphStyle.lineHeightMultiple = Constants.lineHeightMultipler
        let mutableString = NSAttributedString(string: string, attributes: attributes)
        return mutableString
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.titleTopPadding),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.titleTopPadding),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.leftPadding),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: Constants.rightPadding),

            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.titleTopPadding),
            dateLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.leftPadding),
            dateLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: Constants.rightPadding),

            descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: Constants.titleTopPadding),
            descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.leftPadding),
            descriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: Constants.rightPadding),
            descriptionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }

    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
}
