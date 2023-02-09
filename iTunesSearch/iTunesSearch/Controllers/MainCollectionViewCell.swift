//
//  MainCollectionViewCell.swift
//  iTunesSearch
//
//  Created by Burak Erden on 9.02.2023.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    
    @IBOutlet weak var collectionPrice: UILabel!
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
