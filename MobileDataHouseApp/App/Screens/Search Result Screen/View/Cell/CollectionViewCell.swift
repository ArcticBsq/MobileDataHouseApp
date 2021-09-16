//
//  CollectionViewCell.swift
//  MobileDataHouseApp
//
//  Created by Илья Москалев on 16.09.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
    }
}
