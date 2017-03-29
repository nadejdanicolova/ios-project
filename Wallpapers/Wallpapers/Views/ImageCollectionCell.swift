//
//  ImageCollectionCell.swift
//  Wallpapers
//
//  Created by Nadejda on 3/26/17.
//
//

import UIKit
import FaveButton

class ImageCollectionCell: UICollectionViewCell{

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
 
    
}
