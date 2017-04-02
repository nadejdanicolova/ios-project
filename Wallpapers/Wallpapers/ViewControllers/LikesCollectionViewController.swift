import UIKit
import CoreData

private let reuseIdentifier = "Cell"

class LikesCollectionViewController: UICollectionViewController {
    var images: [LikedImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        let cellNib = UINib(nibName: "ImageCollectionCell", bundle: nil)
        self.collectionView?.register(cellNib, forCellWithReuseIdentifier: reuseIdentifier)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as!
        ImageCollectionCell
        
        let imageUrl = self.images[indexPath.row].url
        let url = URL(string: imageUrl!)
        cell.image.kf.setImage(with: url)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let imageId = "\(self.images[indexPath.row].id)"
        let nextVC = UIStoryboard(name: "Main" , bundle: nil).instantiateViewController(withIdentifier: "imagePreviewViewController") as! ImagePreviewViewController
        nextVC.imageId = imageId
        
        self.show(nextVC, sender: self)
        
    }
    
    var appDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
    
    var managedObjectContext: NSManagedObjectContext {
        get {
            return self.appDelegate.persistentContainer.viewContext
        }
    }
    
    func loadData() {
        do {
            self.images = try self.managedObjectContext.fetch(LikedImage.fetchRequest())
            
        } catch  {
            print("load data error")
        }
    }
}
