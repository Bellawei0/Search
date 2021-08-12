//
//  MainViewController.swift
//  Search
//
//  Created by Bella Wei on 8/5/21.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    enum Constants {
        static let edgeInsets = UIEdgeInsets(top: 16, left: 20, bottom: 15, right: 16)
        static let itemWidth: CGFloat = 330
        static let screenSize = UIScreen.main.bounds.width
        static let itemHeight: CGFloat = 380
        static let minimumItemSpacing: CGFloat = 20
        static let searchBarHeight: CGFloat = 50
        static let searchBarLeftPadding: CGFloat = 10
        static let searchBarWidthPadding: CGFloat = 20
        static let heightPadding: CGFloat = 55
        static let zeroPadding: CGFloat = 0
    }

    typealias DataSource = UICollectionViewDiffableDataSource<Int, SearchViewModel>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, SearchViewModel>

    private var dataSource: DataSource?
    private var snapshot = DataSourceSnapshot()
    private var collectionView: UICollectionView!
    private let searchBar = UISearchBar()
    private var SearchResults: [Result] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.backgroundColor = .systemBackground
        searchBar.frame = CGRect(x: Constants.searchBarLeftPadding, y: view.safeAreaInsets.top, width: view.frame.size.width - Constants.searchBarWidthPadding, height: Constants.searchBarHeight)
        collectionView?.frame = CGRect(x: Constants.zeroPadding, y: view.safeAreaInsets.top + Constants.heightPadding, width: view.frame.size.width, height: view.frame.size.height - Constants.heightPadding)
    }

    func fetchResults(query: String) {
        NasaClient.shared.fetchResults(query: query) { [weak self] data, error in
            guard let self = self else { return }
            guard error == nil else { return }
            if let data = data {
                self.SearchResults = data.collection.items
                self.SearchResults = self.SearchResults.sortResult()
                self.applySnapshot(results: self.SearchResults.map { SearchViewModel(result: $0) })
                self.collectionView?.reloadData()
            }
        }
    }

    private func setupViews() {
        collectionView?.removeFromSuperview()
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = Constants.minimumItemSpacing
        layout.minimumLineSpacing = Constants.minimumItemSpacing
        layout.scrollDirection = .vertical
        layout.invalidateLayout()
        layout.sectionInset = Constants.edgeInsets
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground

        view.addSubview(searchBar)
        view.addSubview(collectionView)
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        collectionView.delegate = self
        dataSource = configureDataSource(for: collectionView)

        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.Constants.indentifier)
    }

    private func applySnapshot(results: [SearchViewModel]?) {
        snapshot = DataSourceSnapshot()
        snapshot.appendSections([0])

        guard let searchResults = results else { return }
        snapshot.appendItems(searchResults)

        dataSource?.apply(snapshot, animatingDifferences: true)
    }

    private func configureDataSource(for collectionView: UICollectionView) -> DataSource {
        let dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, SearchViewModel -> ImageCollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.Constants.indentifier, for: indexPath) as? ImageCollectionViewCell else { return nil }
            let viewModel = SearchViewModel
            cell.configure(with: viewModel)
            return cell
        })
        return dataSource
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewModel = dataSource?.itemIdentifier(for: indexPath) {
            let vc = SearchDetailsViewController(viewModel: viewModel)
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .coverVertical
            present(navigationController, animated: true, completion: nil)
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: Constants.screenSize - Constants.edgeInsets.left * 2, height: Constants.itemHeight)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        scrollToTop()
        if let text = searchBar.text {
            fetchResults(query: text)
            collectionView.reloadData()
            collectionView.isHidden = false
        }
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange _: String) {
        if searchBar.text == "" {
            self.SearchResults = []
            collectionView.reloadData()
            collectionView.isHidden = true
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.endEditing(true)
        print("Cancel button is clicked")
        self.SearchResults = []
        collectionView.reloadData()
        collectionView.isHidden = true
    }
}

extension MainViewController {
    func scrollToTop() {
        collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}
