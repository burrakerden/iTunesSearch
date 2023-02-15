//
//  MainViewController.swift
//  iTunesSearch
//
//  Created by Burak Erden on 9.02.2023.
//

import UIKit
import Alamofire
import SDWebImage
import SDWebImageSVGCoder

class MainViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var centerIndicator: UIActivityIndicatorView!
    
    var model = ViewModel()
    var service = Service()
    var data = [Result]()
    
    var searchText = ""
    var limit = 19
    var entity = "movie"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func segmentDidChanged(_ sender: UISegmentedControl) {
        mainCollectionView.setContentOffset(CGPoint.zero, animated: true)
        data.removeAll()
        mainCollectionView.reloadData()
        centerIndicator.isHidden = false
        centerIndicator.startAnimating()
        switch sender.selectedSegmentIndex {
        case 0:
            entity = "movie"
            bind(entity: entity, limit: limit, searchText: searchText)
        case 1:
            entity = "music"
            bind(entity: entity, limit: limit, searchText: searchText)
        case 2:
            entity = "software"
            bind(entity: entity, limit: limit, searchText: searchText)
        case 3:
            entity = "ebook"
            bind(entity: entity, limit: limit, searchText: searchText)
        default:
            print("NOTHING selected")
        }
    }
    
    func bind(entity: String, limit: Int, searchText: String) {
        model.getData(entity: entity, limit: limit, searchText: searchText)
        model.data = {[weak self] value in
            guard let self = self else {return}
            self.data = value
            self.indicator.isHidden = true
            self.indicator.stopAnimating()
            self.centerIndicator.isHidden = true
            self.centerIndicator.stopAnimating()
            self.mainCollectionView.reloadData()
        }
        
    }
    
    func setupUI() {
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
        navigationItem.title = "Search"
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
        self.indicator.isHidden = true
        self.centerIndicator.isHidden = true
    }
}

//MARK: - Collection View

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MainCollectionViewCell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell else {return UICollectionViewCell()}
        let data = data[indexPath.row]
        
        if indexPath.row == limit - 1 {
            limit += 20
            indicator.isHidden = false
            indicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.bind(entity: self.entity, limit: self.limit, searchText: self.searchText)
            }
        }
        
        cell.prepareCell(data: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.data = data[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Search Bar

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 3 {
            self.searchText = searchText.replacingOccurrences(of: " ", with: "+")
            bind(entity: entity, limit: limit, searchText: searchText)
        } else {
            limit = 19
            data.removeAll()
            mainCollectionView.reloadData()
        }
    }
}
