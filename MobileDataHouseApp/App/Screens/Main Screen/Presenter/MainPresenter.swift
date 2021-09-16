//
//  MainPresenter.swift
//  MobileDataHouseApp
//
//  Created by Илья Москалев on 16.09.2021.
//

import Foundation

protocol MainViewProtocol: AnyObject {
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol)
}

class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    
    required init(view: MainViewProtocol) {
        self.view = view
    }
}
