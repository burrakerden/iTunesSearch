//
//  Model.swift
//  iTunesSearch
//
//  Created by Burak Erden on 13.02.2023.
//

import Foundation
import UIKit
import Alamofire

class Model {
    
    var data = [Result]()
    
    //MARK: - GET DATA
    
    func getData(mainCollectionView: UICollectionView) {
        Service().getData() { result in
            guard let result = result?.results else {return}
            self.data = result
            mainCollectionView.reloadData()
        } onError: { error in
            print(error)
        }
    }
    
    //MARK: - DATE FORMATTER
    
    func dateFormaater(dateToChange: String) -> String {
        let string = String(dateToChange)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: string)!
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    //MARK: - SEGMENT

    
    //MARK: - SETUP UI
    
    func setupUI(mainCollectionView: UICollectionView, navigationItem: UINavigationItem, navigationController: UINavigationController) {
        mainCollectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
        navigationItem.title = "Search"
        navigationItem.backButtonTitle = ""
        navigationController.navigationBar.tintColor = .black
    }
}
