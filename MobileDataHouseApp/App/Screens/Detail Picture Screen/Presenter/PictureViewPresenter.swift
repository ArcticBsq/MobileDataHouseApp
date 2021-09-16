//
//  PictureViewPresenter.swift
//  MobileDataHouseApp
//
//  Created by Илья Москалев on 16.09.2021.
//

import Foundation

protocol PictureViewProtocol: AnyObject {
    func setupView()
}

protocol PictureViewPresenterPrototol: AnyObject {
    init(view: PictureViewProtocol, pictureUrl: URL)
    var highResUrl: URL? { get set }
    func setupView()
}

class PictureViewPresenter: PictureViewPresenterPrototol {
    weak var view: PictureViewProtocol?
    var highResUrl: URL?
    
    required init(view: PictureViewProtocol, pictureUrl: URL) {
        self.view = view
        self.highResUrl = pictureUrl
        setupView()
    }
    
    func setupView() {
        self.view?.setupView()
    }
}
