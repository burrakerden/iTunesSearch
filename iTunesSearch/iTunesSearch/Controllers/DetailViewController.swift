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
    var model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        guard let data = data else {return}
        
        detailName.text = data.trackName
        detailDescription.text = data.description?.html2String
        detailMovieDescription.text = data.longDescription
        detailDate.text = model.dateFormaater(dateToChange: data.releaseDate ?? "")
        detailArtist.text = data.artistName
        
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
        if let url = data.artworkUrl100 {
            image.sd_setImage(with: URL(string: url))
        }

        if let price = data.collectionPrice {
            detailPrice.text = "$ \(price)"
        } else {
            detailPrice.text = "free"
        }
    }
    
}
