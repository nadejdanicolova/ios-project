import UIKit

class CategoriesTableViewController: UITableViewController{
    var categoriesImages: [UIImage] = [UIImage(named:"animals")!, UIImage(named:"backgrounds")!, UIImage(named:"computers")! , UIImage(named:"fashion")! , UIImage(named:"feelings")!, UIImage(named:"music")!, UIImage(named:"nature")!, UIImage(named:"places")!, UIImage(named:"science")!]
    
    var categoriesNames : [String] = ["animals", "backgrounds", "computer", "fashion" , "feelings", "music", "nature", "places" ,"science"]
    
    private let reuseIdentifier = "url-cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "CategoriesTableViewCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.showLoadingScreen()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async{
            self.hideLoadingScreen()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoriesNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as!
        CategoriesTableViewCell
        
        cell.collectionImage.image = self.categoriesImages[indexPath.row]
        cell.collectionName.text = self.categoriesNames[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let categoryName = self.categoriesNames[indexPath.row]
        let nextVC = UIStoryboard(name: "Main" , bundle: nil).instantiateViewController(withIdentifier: "galleryCollectionViewController" ) as! GalleryCollectionViewController
        
        nextVC.category = categoryName
        self.show(nextVC, sender: self)
    }
}
