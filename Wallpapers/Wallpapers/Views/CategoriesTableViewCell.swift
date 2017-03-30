//
//  CategoriesTableViewCell.swift
//  Wallpapers
//
//  Created by Nadejda on 3/30/17.
//
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var collectionImage: UIImageView!
    @IBOutlet weak var collectionName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
