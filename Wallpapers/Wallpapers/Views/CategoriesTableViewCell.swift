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
