//
//  File.swift
//  Wallpapers
//
//  Created by Nadejda on 3/23/17.
//
//

import Foundation
import UIKit
import SwiftSpinner

extension UIViewController{
    func showLoadingScreen(textToShow: String = "Loading"){
           SwiftSpinner.show(textToShow)
    }
    
    func hideLoadingScreen(){
        SwiftSpinner.hide()
    }
    
}
