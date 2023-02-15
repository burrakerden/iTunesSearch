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
    @IBOutlet weak var detailArtist: UILabel!
    
    var data: Result?
    var entity: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        guard let data = data else {return}
        
        switch entity {
        case "movie":
            detailDescription.text = data.longDescription
        case "music":
            detailDescription.text = ""
        case "software":
            detailDescription.text = data.description
        case "ebook":
            detailDescription.text = data.description?.html2String
        default:
            print("NOTHING selected")
        }
        
        detailName.text = data.trackName
        detailDate.text = String().dateFormaater(dateToChange: data.releaseDate ?? "")
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
