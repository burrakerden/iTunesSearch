//
//  Service.swift
//  iTunesSearch
//
//  Created by Burak Erden on 9.02.2023.
//

import Alamofire

protocol ServiceProtocol {
    func getData(entity: String, limit: Int, searchText: String, onSuccess: @escaping (SearchApi?) -> Void, onError: @escaping (AFError) -> Void)
}

final class Service: ServiceProtocol {
    
    func getData(entity: String, limit: Int, searchText: String, onSuccess: @escaping (SearchApi?) -> Void, onError: @escaping (Alamofire.AFError) -> Void) {
        ServiceManager.shared.fetch(path: "https://itunes.apple.com/search?term=\(searchText)&media=\(entity)&limit=\(limit)") { (response: SearchApi) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
}
