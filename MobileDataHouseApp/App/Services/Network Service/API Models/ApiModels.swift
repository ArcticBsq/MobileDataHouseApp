//
//  ApiModels.swift
//  MobileDataHouseApp
//
//  Created by Илья Москалев on 16.09.2021.
//

import Foundation

struct SearchResults: Decodable {
    let total: Int
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Decodable {
    let width: Int
    let height: Int
    let urls: Urls
}

struct Urls: Decodable {
    var raw: String
    var full: String
    var regular: String
    var small: String
    var thumb: String
}
