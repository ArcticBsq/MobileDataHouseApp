//
//  SearchResultViewController.swift
//  MobileDataHouseApp
//
//  Created by Илья Москалев on 16.09.2021.
//

import UIKit

class SearchResultViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: SearchViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        title = presenter.searchTerm?.capitalized
    }
    
    private func showSearchScreen(url: URL) {
        let vc = ModelBuilder.createPictureDetailModule(url: url)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchResultViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width-15)/2, height: collectionView.frame.width/1.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.pictures?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if let cell = cell as? CollectionViewCell {
            if let lowResUrlString = presenter.pictures?.results[indexPath.row].urls.small {
                if let lowResUrl = URL(string: lowResUrlString) {
                    cell.imageView.cacheImage(url: lowResUrl)
                    cell.activityIndicator.stopAnimating()
                    activityIndicator.stopAnimating()
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let highResUrlString = presenter.pictures?.results[indexPath.row].urls.full {
            if let highResUrl = URL(string: highResUrlString) {
                self.showSearchScreen(url: highResUrl)
            }
        }
    }
}

extension SearchResultViewController: SearchViewProtocol {
    func emptySuccess() {
        let ac = UIAlertController(title: "Oops", message: "Requst sent zero pictures, try to make request more accurately.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
            guard let self = self else { return }
            self.navigationController?.popToRootViewController(animated: true)
        }))
        present(ac,animated: true)
    }
    
    func success() {
        collectionView.reloadData()
    }
    
    func failure(error: Error) {
        let ac = UIAlertController(title: "Error", message: "Error - \(error.localizedDescription)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Close", style: .cancel))
        ac.addAction(UIAlertAction(title: "Reload", style: .default, handler: { [weak self] action in
            guard let self = self else { return }
            self.presenter.getPictures(searchTerm: self.presenter.searchTerm)
        }))
        present(ac,animated: true)
    }
}
