//
//  ImageDictionary.swift
//  Wallpapers
//
//  Created by Nadejda on 3/23/17.
//
//

import Foundation

extension Image {
    convenience init(withDict dict: Dictionary<String , Any>){
        let id = dict["id"] as! String
        let previewUrl = dict["previewUrl"] as! String
        let tags = dict["tags"] as! String
        let likes = dict["likes"] as! Int
        
        self.init(withId :id, previewUrl: previewUrl,tags: tags, andLikes :likes)
    }
}
