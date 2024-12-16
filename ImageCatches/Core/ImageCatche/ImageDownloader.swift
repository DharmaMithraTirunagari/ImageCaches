//
//  ImageDownloader.swift
//  ImageCatches
//
//  Created by Srikanth Kyatham on 12/9/24.
//

import UIKit

class ImageDownloader {
    static let shared = ImageDownloader()
    private init() {}
    private let imageCache = NSCache<NSString, UIImage>()
    
    func getImage(url: String?, completion: @escaping (UIImage) -> Void) {
        guard let url = url else {
            completion(UIImage(named: "template")!)
            return
        }
        
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            completion(cachedImage)
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            if let dataUrl = URL(string: url), let data = try? Data(contentsOf: dataUrl), let image = UIImage(data: data) {
                self.imageCache.setObject(image, forKey: url as NSString)
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(UIImage(named: "template")!)
                }
            }
        }
    }
}
