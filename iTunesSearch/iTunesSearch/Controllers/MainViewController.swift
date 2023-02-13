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
    
    var model = Model()
    var service = Service()
    var data = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupUI()
    }
    
    @IBAction func segmentDidChanged(_ sender: UISegmentedControl) {
        service.limit = 19
        switch sender.selectedSegmentIndex {
        case 0:
            service.entity = "movie"
            getData()
        case 1:
            service.entity = "music"
            getData()
        case 2:
            service.entity = "software"
            getData()
        case 3:
            service.entity = "ebook"
            getData()
        default:
            print("NOTHING selected")
        }
    }
    
    func getData() {
        service.getData() { result in
            guard let result = result?.results else {return}
            self.data = result
            self.mainCollectionView.reloadData()
        } onError: { error in
            print(error)
        }
    }
    
    func setupUI() {
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        model.setupUI(mainCollectionView: mainCollectionView, navigationItem: navigationItem, navigationController: navigationController!)
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
        if indexPath.row == service.limit - 1 {
            service.limit += 20
            getData()
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
            service.searchText = searchText.replacingOccurrences(of: " ", with: "+")
            getData()
        } else {
            service.limit = 19
            data.removeAll()
            mainCollectionView.reloadData()
        }
    }
}
