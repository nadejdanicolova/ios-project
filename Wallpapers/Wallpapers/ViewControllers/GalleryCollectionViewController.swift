import UIKit
import Kingfisher

private let reuseIdentifier = "Cell"

class GalleryCollectionViewController: UICollectionViewController, HttpRequesterDelegate {
    var choosenCategory: String = ""
    var images: [Image] = []
    
    var category: String {
        get{
             return self.choosenCategory
        }
        set(value){
            self.choosenCategory = value
        }
    }
    
    var url: String {
        get{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return "\(appDelegate.baseUrl)&per_page=5&category=\(choosenCategory)"
        }
    }
    
    var http: HttpRequester? {
        get{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.http
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "ImageCollectionCell", bundle: nil)
        
        self.http?.delegate = self
        self.http?.get(fromUrl: self.url)
        self.collectionView?.register(cellNib, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let screenSize = UIScreen.main.fixedCoordinateSpace.bounds
        let width = screenSize.width / 2
        let height = screenSize.height / 2
        
        return CGSize(width: width, height: height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func didReceiveData(data: Any) {
        
        let dataArray = data as! [Dictionary<String, Any>]
        
        self.images = dataArray.map(){Image(withDict: $0)}
        
        DispatchQueue.main.async{
            self.collectionView?.reloadData()
        }
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
        
        //let screenSize = UIScreen.main.fixedCoordinateSpace.bounds
        //let width = screenSize.width / 2
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as!
        ImageCollectionCell
        
        // cell.image.sizeThatFits(CGSize(width: width, height: width))
        
        let imageUrl = self.images[indexPath.row].previewUrl
        
        let url = URL(string: imageUrl!)
        cell.image.kf.setImage(with: url)
        cell.likesCount.text = "\(self.images[indexPath.row].likes!)"
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let imageId = "\(self.images[indexPath.row].id!)"
        let nextVC = UIStoryboard(name: "Main" , bundle: nil).instantiateViewController(withIdentifier: "imagePreviewViewController") as! ImagePreviewViewController
        nextVC.imageId = imageId
        
        self.show(nextVC, sender: self)
        
    }

    
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
