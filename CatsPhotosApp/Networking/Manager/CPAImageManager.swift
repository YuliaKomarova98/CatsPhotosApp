//
//  CPAImageManager.swift
//  CatsPhotosApp
//
//  Created by Yulia on 12.10.2021.
//

import Foundation
import UIKit

class CPAImageManager {
    func getImage(urlData: String, completionHandler: @escaping(UIImage?) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: urlData) else { return }
            
        let request = URLRequest(url: url)
        let dataTak = session.dataTask(with: request) { data, response, error in
                
            guard error == nil, data != nil else { return }
                
            DispatchQueue.main.async {
                guard let image = UIImage(data: data!) else { return }
                    
                completionHandler(image)
            }
        }
        dataTak.resume()
    }
}
