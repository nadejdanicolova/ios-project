//
//  Image.swift
//  Wallpapers
//
//  Created by Nadejda on 3/23/17.
//
//

import UIKit

class Image{

    var id:String?
    var tags: String?
    var previewUrl: String?
    var likes : Int?
    
    convenience init(withPreviewUrl previewUrl: String){
        self.init(withId: "", previewUrl: previewUrl, tags: "", andLikes: 0)
    }
    
    init(withId id:String, previewUrl: String,tags: String, andLikes likes: Int){
        self.id = id
        self.previewUrl = previewUrl
        self.likes = likes
    }
}
