//
//  PictureViewController.swift
//  MobileDataHouseApp
//
//  Created by Илья Москалев on 16.09.2021.
//

import UIKit

final class PictureViewController: UIViewController {
    @IBOutlet weak var pictureImageView: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var presenter: PictureViewPresenterPrototol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setupView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
    }
}

extension PictureViewController: PictureViewProtocol {
    func setupView() {
        if presenter != nil {
            guard let url = presenter.highResUrl else { return }
            pictureImageView.cacheImage(url: url)
            activityIndicator.stopAnimating()
        }
    }
}
