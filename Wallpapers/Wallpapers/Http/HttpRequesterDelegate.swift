//
//  HttpRequesterDelegate.swift
//  Wallpapers
//
//  Created by Nadejda on 3/23/17.
//
//

import UIKit

protocol HttpRequesterDelegate {
    func didReceiveData(data: Any)
    func didReceiveError(error: Error)
}

extension HttpRequesterDelegate {
    func didReceiveData(data: Any) {
        
    }
    
    func didReceiveError(error: Error){
        
    }
    
}
