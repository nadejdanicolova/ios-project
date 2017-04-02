import UIKit
import LIHAlert
import CoreData

class ImagePreviewViewController: UIViewController, HttpRequesterDelegate {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var tags: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    
    var successAlert: LIHAlert?
    var errorAlert: LIHAlert?
    
    var imageInfo : Image? = nil
    var images: [Image] = []
    var id : String = ""
    
    var imagesToShow: [LikedImage] = []
    var imagesToCheck: [LikedImage] = []
    
    
    var imageId: String {
        get {
            return self.id
        }
        set(value) {
            self.id = value
        }
    }
    
    var url: String {
        get{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return "\(appDelegate.baseUrl)&id=\(imageId)"
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
        loadData()
        
        self.http?.delegate = self
        self.http?.get(fromUrl: self.url)
        
        self.successAlert = LIHAlertManager.getSuccessAlert(message: "Image is saved")
        self.successAlert?.initAlert(self.view)
        
        self.errorAlert = LIHAlertManager.getErrorAlert(message: "Failed. Please try again")
        self.errorAlert?.initAlert(self.view)
        
    }
    
       func showBanner(sender: AnyObject) {
        self.successAlert?.show(nil, hidden: nil)
    }
    
    func showError(sender: AnyObject) {
        self.errorAlert?.show(nil, hidden: nil)
    }
    
    func loadData() {
        do {
            self.imagesToCheck = try self.managedObjectContext.fetch(LikedImage.fetchRequest())
            
        } catch  {
            print("load data error")
        }
        
    }
    
    func checkIfAdded(){
        for img in imagesToCheck {
            let imgId = Int32((imageInfo?.id)!)
            if(imgId == img.id){
                btnLike.setTitle("Dislike", for: .normal)
                return
            }
            else{
                btnLike.setTitle("Like", for: .normal)
                return
            }
        }
    }
    
    @IBAction func likeImage(_ sender: Any) {
        let btnText = btnLike.titleLabel!.text
        
        if(btnText == "Like"){
            btnLike.setTitle("Dislike", for: .normal)
            
            let imageUrl = self.imageInfo!.previewUrl
            let imageId = self.imageInfo!.id
            
            let entity = NSEntityDescription.entity(forEntityName: "LikedImage", in: self.managedObjectContext)
            
            let likedImage: LikedImage =
                LikedImage(entity: entity!, insertInto: self.managedObjectContext)
            
            likedImage.id = Int32(imageId!)
            likedImage.url = imageUrl
           likedImage.isLiked = true
            
            self.managedObjectContext.insert(likedImage)
            
            self.appDelegate.saveContext()
            
        }
         if(btnText == "Dislike"){
            btnLike.setTitle("Like", for: .normal)
            
            let imageUrl = self.imageInfo?.previewUrl
            let imageId = self.imageInfo?.id
            
            let entity = NSEntityDescription.entity(forEntityName: "LikedImage", in: self.managedObjectContext)
            
            let likedImage: LikedImage =
                LikedImage(entity: entity!, insertInto: self.managedObjectContext)
            
            likedImage.id = Int32(imageId!)
            likedImage.url = imageUrl
            likedImage.isLiked = false
            
            self.managedObjectContext.delete(likedImage)
            self.appDelegate.saveContext()
            
        }
        
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
    
    @IBAction func saveImage(_ sender: Any) {
        do {
            
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsURL.appendingPathComponent("\(imageInfo?.id).png")
            
            if let pngImageData = UIImagePNGRepresentation(image.image!) {
                try pngImageData.write(to: fileURL, options: .atomic)
                showBanner(sender: successAlert!)
            }
        } catch {
            showError(sender: errorAlert!)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func didReceiveData(data: Any) {
        
        let dataArray = data as! [Dictionary<String, Any>]
        
        self.images = dataArray.map(){Image(withDict: $0)}
        self.imageInfo = self.images.first
        
        DispatchQueue.main.async{
            self.checkIfAdded()
            let imageUrl = self.imageInfo?.previewUrl
            let url = URL(string: imageUrl!)
            
            self.image.kf.setImage(with: url)
            self.tags!.text = "Tags: \(self.imageInfo!.tags!)"
        }
        
    }
}
