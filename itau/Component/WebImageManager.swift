//
//  WebImageManager.swift
//  itau
//
//  Created by André Lucas on 14/09/21.
//

import Foundation
import UIKit
class WebImageManager{
    
    static let instance = WebImageManager()
    var imageCache = NSCache<NSString, UIImage>()
    
    init(){}
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
        session.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
        }.resume()
    }
    
    func downloadImage(url: URL, identifier: NSString, imageViewField: UIImageView, onDownloadFailed: @escaping () -> Void) {
        imageViewField.image = nil;
        if let image = imageCache.object(forKey: identifier){
            imageViewField.image = image
            return
        } else {
            getDataFromUrl(url: url) { (data, response, error) in
                guard let data = data, error == nil else { onDownloadFailed(); return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                DispatchQueue.main.async() { () -> Void in
                    if let imageFromWeb = UIImage(data: data){
                        imageViewField.image = imageFromWeb
                        self.imageCache.setObject(imageFromWeb, forKey: identifier)
                    } else {
                        onDownloadFailed()
                    }
                }
            }
        }
    }
}

