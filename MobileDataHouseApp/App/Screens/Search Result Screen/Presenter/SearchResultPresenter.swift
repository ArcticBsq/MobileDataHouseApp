//
//  SearchResultPresenter.swift
//  MobileDataHouseApp
//
//  Created by Илья Москалев on 16.09.2021.
//

import Foundation

protocol SearchViewProtocol: AnyObject {
    func success()
    func emptySuccess()
    func failure(error: Error)
}

protocol SearchViewPresenterProtocol: AnyObject {
    init(view: SearchViewProtocol, networkService: NetworkDataFetcherProtocol, searchTerm: String?)
    func getPictures(searchTerm: String?)
    var pictures: SearchResults? { get set }
    var searchTerm: String? { get set }
}

final class SearchPresenter: SearchViewPresenterProtocol {
    weak var view: SearchViewProtocol?
    let networkService: NetworkDataFetcherProtocol!
    var pictures: SearchResults? 
    var searchTerm: String?
    
    required init(view: SearchViewProtocol, networkService: NetworkDataFetcherProtocol, searchTerm: String?) {
        self.view = view
        self.networkService = networkService
        self.searchTerm = searchTerm
        getPictures(searchTerm: searchTerm)
    }
    
    func getPictures(searchTerm: String?) {
        networkService.fetchImages(searchTerm: searchTerm ?? "") { [weak self] result, error  in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if let result = result {
                    if !result.results.isEmpty {
                        self.pictures = result
                        self.view?.success()
                    } else {
                        self.view?.emptySuccess()
                    }
                } else {
                    guard let error = error else { return }
                    self.view?.failure(error: error)
                }
            }
        }
    }
}
