//
//  ImagePreviewViewController.swift
//  Wallpapers
//
//  Created by Nadejda on 3/30/17.
//
//

import UIKit

class ImagePreviewViewController: UIViewController, HttpRequesterDelegate {
    
   
    @IBOutlet weak var image: UIImageView!
   
    @IBOutlet weak var tags: UILabel!
    
    var imageInfo : Image? = nil
    var images: [Image] = []
    
    var url: String {
        get{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return "\(appDelegate.baseUrl)&id=195893"
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
    }
    
    
    @IBAction func SaveImage(_ sender: Any) {
        
        do {
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsURL.appendingPathComponent("\(imageInfo?.id).png")
       
            if let pngImageData = UIImagePNGRepresentation(image.image!) {
                try pngImageData.write(to: fileURL, options: .atomic)
                print("work")
            }
        } catch {
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didReceiveData(data: Any) {
        
        let dataArray = data as! [Dictionary<String, Any>]
        
        self.images = dataArray.map(){Image(withDict: $0)}
        
        self.imageInfo = self.images.first
        
        DispatchQueue.main.async{
            
        }
        let imageUrl = self.imageInfo?.previewUrl
        
        let url = URL(string: imageUrl!)
        self.image.kf.setImage(with: url)
      
        
        self.tags!.text = "Tags: \(self.imageInfo!.tags!)"
       
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
