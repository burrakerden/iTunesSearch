//
//  MainCollectionViewCell.swift
//  iTunesSearch
//
//  Created by Burak Erden on 9.02.2023.
//

import UIKit
import SDWebImage
import SDWebImageSVGCoder

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var collectionPrice: UILabel!
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func prepareCell(data: Result) {
        
        collectionName.text = data.trackName
        releaseDate.text = String().dateFormaater(dateToChange: data.releaseDate ?? "")
        
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
        if let url = data.artworkUrl100 {
            cellImage.sd_setImage(with: URL(string: url))
        }
        
        if let price = data.collectionPrice {
            collectionPrice.text = "$ \(price)"
        } else {
            collectionPrice.text = "free"
        }
    }
}
