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
