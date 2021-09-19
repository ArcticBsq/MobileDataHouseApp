//
//  ModuleBuilder.swift
//  MobileDataHouseApp
//
//  Created by Илья Москалев on 16.09.2021.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
    static func createFilterModule(searchTerm: String?) -> UIViewController
    static func createPictureDetailModule(url: URL) -> UIViewController
}

final class ModelBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    static func createFilterModule(searchTerm: String?) -> UIViewController {
        let view = SearchResultViewController()
        let networkService = NetworkDataFetcher()
        let presenter = SearchPresenter(view: view, networkService: networkService, searchTerm: searchTerm)
        view.presenter = presenter
        return view
    }
    
    static func createPictureDetailModule(url: URL) -> UIViewController {
        let view = PictureViewController()
        let presenter = PictureViewPresenter(view: view, pictureUrl: url)
        view.presenter = presenter
        return view
    }
}
