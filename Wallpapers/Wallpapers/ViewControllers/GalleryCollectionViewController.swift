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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as!
        ImageCollectionCell
        
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
}
