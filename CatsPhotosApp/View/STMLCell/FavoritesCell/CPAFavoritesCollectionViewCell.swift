//
//  STMFavoritesCollectionViewCell.swift
//  CatsPhotosApp
//
//  Created by Yulia on 13.10.2021.
//

import UIKit

class CPAFavoritesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }

}
