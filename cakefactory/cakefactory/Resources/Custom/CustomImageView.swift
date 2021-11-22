//
//  CustomImageView.swift
//  cakefactory
//
//  Created by Jose Maria Marquez on 22/11/21.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {

    var task: URLSessionDataTask!


    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        if let task = self.task {
            task.cancel()
        }
        self.task = URLSession.shared.dataTask(with: url, completionHandler: completion)
        self.task.resume()
    }

    func downloadImage(from url: URL) {
        self.image = UIImage(named: "splashCake")

        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }

        getData(from: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data), error == nil else { return }
            imageCache.setObject(image, forKey: url.absoluteString as AnyObject)
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }
    }
}
