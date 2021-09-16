//
//  NetworkService.swift
//  MobileDataHouseApp
//
//  Created by Илья Москалев on 16.09.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func createDataTask(from request: URLRequest, completion: @escaping (Data? , Error?) -> Void) -> URLSessionDataTask
    func request(searchTerm: String, completion: @escaping (Data?, Error?) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    internal func createDataTask(from request: URLRequest, completion: @escaping (Data? , Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
    func request(searchTerm: String, completion: @escaping (Data?, Error?) -> Void)  {
        guard let _url = URL(string: "https://api.unsplash.com/search/photos?per_page=30&page=1&query=\(searchTerm.lowercased().replacingOccurrences(of: " ", with: ""))&client_id=G4lYE2JVObF72r6Y1TB-BgXotSIoRgBUbSxKIg7D9W4") else { return }
        var request = URLRequest(url: _url)
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
}
