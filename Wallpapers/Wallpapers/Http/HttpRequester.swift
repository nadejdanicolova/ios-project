//
//  HttpRequester.swift
//  Wallpapers
//
//  Created by Nadejda on 3/23/17.
//
//

import UIKit

class HttpRequester {
    
    var delegate: HttpRequesterDelegate?
    
    func get(fromUrl urlString: String)
    {
        let url = URL(string: urlString)
        
        let request = URLRequest(url: url!)
        
        weak var weakSelf = self
        
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler:
            {bodyData, response,error in
                do{
                let body = try JSONSerialization.jsonObject(with: bodyData!, options: .allowFragments)
                    print(body)
                    weakSelf?.delegate?.didReceiveData(data : body)
                }
                catch{
                    weakSelf?.delegate?.didReceiveError(error : error)

                }
        })
        
        dataTask.resume()
    } 
}
