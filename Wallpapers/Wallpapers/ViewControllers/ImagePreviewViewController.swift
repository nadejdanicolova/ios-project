import UIKit
import LIHAlert

class ImagePreviewViewController: UIViewController, HttpRequesterDelegate {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var tags: UILabel!
    
    var successAlert: LIHAlert?
    var errorAlert: LIHAlert?
    
    var imageInfo : Image? = nil
    var images: [Image] = []
    var id : String = ""
    
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
            let imageUrl = self.imageInfo?.previewUrl
            let url = URL(string: imageUrl!)
            
            self.image.kf.setImage(with: url)
            self.tags!.text = "Tags: \(self.imageInfo!.tags!)"
        }
        
    }
}
