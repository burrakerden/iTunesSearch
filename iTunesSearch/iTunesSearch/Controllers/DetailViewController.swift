//
//  DetailViewController.swift
//  iTunesSearch
//
//  Created by Burak Erden on 9.02.2023.
//

import UIKit
import SDWebImage
import SDWebImageSVGCoder

class DetailViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var detailDate: UILabel!
    @IBOutlet weak var detailPrice: UILabel!
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    @IBOutlet weak var detailMovieDescription: UILabel!
    
    @IBOutlet weak var detailArtist: UILabel!
    var data: Result?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        guard let data = data else {return}
        detailName.text = data.trackName
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
        if let url = data.artworkUrl100 {
            image.sd_setImage(with: URL(string: url))
        }
        
        let string = String(data.releaseDate!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: string)!
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: date)
        detailDate.text = dateString
        detailArtist.text = data.artistName
        
        
        if let price = data.collectionPrice {
            detailPrice.text = "$ \(price)"
        } else {
            detailPrice.text = "free"
        }
        
        let str = data.description
        let replaced = str?.replacingOccurrences(of: "", with: "")
        detailDescription.text = replaced
        detailMovieDescription.text = data.longDescription
    }
    
    
}
