//
//  NetworkDataFetcher.swift
//  MobileDataHouseApp
//
//  Created by Илья Москалев on 16.09.2021.
//

import Foundation

protocol NetworkDataFetcherProtocol {
    var networkService: NetworkService { get set }
    
    func fetchImages(searchTerm: String, completion: @escaping (SearchResults?, Error?) -> Void)
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T?
}

class NetworkDataFetcher: NetworkDataFetcherProtocol {
    
    var networkService = NetworkService()
    
    func fetchImages(searchTerm: String, completion: @escaping (SearchResults?, Error?) -> Void) {
        networkService.request(searchTerm: searchTerm) { (data, error) in
            if let error = error {
                completion(nil, error)
            }
            
            let decode = self.decodeJSON(type: SearchResults.self, from: data)
            completion(decode, nil)
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
