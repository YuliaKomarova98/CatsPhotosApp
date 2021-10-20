//
//  CPACollectionViewCell.swift
//  CatsPhotosApp
//
//  Created by Yulia on 11.10.2021.
//

import UIKit

class CPACollectionViewCell: UICollectionViewCell {
    var imageManaget = CPAImageManager()

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgeView: UIImageView!
    
    var model: CPACatsModel? {
        didSet {
            guard let model = model else { return }
            
            let imageUrl = model.url
            imageManaget.getImage(urlData: imageUrl) { image in
                guard self.model?.url == imageUrl else { return }
                self.imgeView.image = image
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        model = nil
        imgeView.image = nil
    }
}
