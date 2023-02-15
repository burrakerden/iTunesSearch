//
//  Model.swift
//  iTunesSearch
//
//  Created by Burak Erden on 13.02.2023.
//

import Foundation
import UIKit
import Alamofire

class ViewModel {
    
    var data: (([Result]) -> Void)?
    
    //MARK: - GET DATA
    
    func getData(entity: String, limit: Int, searchText: String) {
        Service().getData(entity: entity, limit: limit, searchText: searchText) { result in
            guard let result = result?.results else {return}
            self.data?(result)
        } onError: { error in
            print(error)
        }
    }
}
