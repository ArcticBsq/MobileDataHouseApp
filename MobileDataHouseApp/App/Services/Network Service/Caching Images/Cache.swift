//
//  Cache.swift
//  MobileDataHouseApp
//
//  Created by Илья Москалев on 16.09.2021.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
  func cacheImage(url: URL) {
    DispatchQueue.main.async {
        self.image = nil
    }

    if let imageFromCache = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
        self.image = imageFromCache
        return
    } else {
        URLSession.shared.dataTask(with: url) { data, resp, error in
            guard let data = data, error == nil else {
                self.cacheImage(url: url)
                return }
            
            let imageToCache = UIImage(data: data)
            imageCache.setObject(imageToCache!, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                self.image = imageToCache
            }
        }.resume()
    }
  }
}
