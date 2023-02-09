//
//  Service.swift
//  iTunesSearch
//
//  Created by Burak Erden on 9.02.2023.
//

import Alamofire

protocol ServiceProtocol {
    func getData(onSuccess: @escaping (SearchApi?) -> Void, onError: @escaping (AFError) -> Void)
}

final class Service: ServiceProtocol {
    var entity = "movie"
    var searchText = ""
    
    func getData(onSuccess: @escaping (SearchApi?) -> Void, onError: @escaping (Alamofire.AFError) -> Void) {
        ServiceManager.shared.fetch(path: "https://itunes.apple.com/search?term=\(searchText)&media=\(entity)") { (response: SearchApi) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
}
