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
                do {
                    let body = try JSONSerialization.jsonObject(with: bodyData!, options: []) as! [String:Any]
                    weakSelf?.delegate?.didReceiveData(data : body["hits"]!)
                }
                catch{
                    weakSelf?.delegate?.didReceiveError(error : error)
                    
                }
        })
        
        dataTask.resume()
    }
}
