//
//  UIImageView+Loading.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 19/3/24.
//

import Foundation
import UIKit

extension UIImageView {
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, completion: ((UIImage?) -> ())? = nil) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else {
                completion?(nil)
                return
            }
            
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.image = UIImage(data: data)
                completion?(self?.image)
            }
        }
    }
}
