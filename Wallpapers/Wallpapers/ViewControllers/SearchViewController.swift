import UIKit

class SearchViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, HttpRequesterDelegate{
    
    let reuseIdentifier = "Search Cell"
    var searchedQuery : String = ""
    var images : [Image] = []
    var handle: Timer?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var url: String {
        get{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let a = "\(appDelegate.baseUrl)&q=\(searchedQuery)"
            print(a)
            return a
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
       
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.searchBar.delegate = self
        
        
        self.http?.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let query = searchBar.text?.lowercased()
        handle?.invalidate()
        
        if((query?.characters.count)! > 3) {
            
            
            handle = setTimeout(delay: 1, block: {
                self.searchedQuery = query!.replacingOccurrences(of: " ", with: "+")
                self.http?.get(fromUrl: self.url)
            })
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didReceiveData(data: Any) {
        
        let dataArray = data as! [Dictionary<String, Any>]
        self.images = dataArray.map(){Image(withDict: $0)}
        
        DispatchQueue.main.async{
            self.collectionView?.reloadData()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionCell
        
        let imageUrl = self.images[indexPath.row].previewUrl
        
        let url = URL(string: imageUrl!)
        cell.image.kf.setImage(with: url)
        cell.likesCount.text = "\(self.images[indexPath.row].likes!)"
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let imageId = "\(self.images[indexPath.row].id!)"
        let nextVC = UIStoryboard(name: "Main" , bundle: nil).instantiateViewController(withIdentifier: "imagePreviewViewController") as! ImagePreviewViewController
        nextVC.imageId = imageId
        
        self.show(nextVC, sender: self)
        
    }
    
    
    //-prehvurlqne-
    func setTimeout(delay:TimeInterval, block:@escaping ()->Void) -> Timer {
        return Timer.scheduledTimer(timeInterval: delay, target: BlockOperation(block: block), selector: #selector(Operation.main), userInfo: nil, repeats: false)
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
