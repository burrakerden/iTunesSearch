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
    
    var service = Service()
    var data = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupUI()
    }

    
    @IBAction func segmentDidChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("Movies selected")
            service.entity = "movie"
            getData()
        case 1:
            print("Music selected")
            service.entity = "music"
            getData()
        case 2:
            print("Apps selected")
            service.entity = "software"
            getData()
        case 3:
            print("Books selected")
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
        mainCollectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
        title = "Search"
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
        cell.collectionName.text = data.trackName
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
        if let url = data.artworkUrl100 {
            cell.cellImage.sd_setImage(with: URL(string: url))
        }
        
        let string = String(data.releaseDate!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: string)!
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: date)
        cell.releaseDate.text = "\(dateString)"
        
        
            if let price = data.collectionPrice {
                cell.collectionPrice.text = "$ \(price)"
            } else {
                cell.collectionPrice.text = "free"
            }
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
            
            let str = searchText
            let replaced = str.replacingOccurrences(of: " ", with: "+")
            service.searchText = replaced
            getData()
            print(replaced)
        }
    }
}
