import Foundation

extension Image {
    
    convenience init(withDict dict: Dictionary<String , Any>){
        let id = dict["id"] as! Int
        let previewUrl = dict["previewURL"] as! String
        let tags = dict["tags"] as! String
        let likes = dict["likes"] as! Int
        
        self.init(withId :id, previewUrl: previewUrl,tags: tags, andLikes :likes)
    }
}
