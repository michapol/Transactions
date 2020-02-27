//
//  ImageProvider.swift
//  Transactions
//
//  Created by Mike Pollard on 25/02/2020.
//  Copyright © 2020 Mike Pollard. All rights reserved.
//

import UIKit

struct ImageProvider {
    
    private static var cache: [ImageRecord] = []
    
    func get(imageURL: String, completion: @escaping (UIImage?)->()) {
        guard let url = URL(string: imageURL) else { completion(nil); return }
        get(imageURL: url, completion: completion)
    }
    
    func get(imageURL: URL, completion: @escaping (UIImage?)->()) {
        if let imageRecord = ImageProvider.cache.first(where: { $0.url == imageURL }) {
            completion(imageRecord.image)
            return
        }
        
        
        DataDownloader().download(url: imageURL) { (data) in
            if let data = data, let image = UIImage(data: data) {
                self.cacheImage(imageURL: imageURL, image: image)
                completion(image)
            }
        }
        
    }
    
    func remove(imageURL: String) {
        ImageProvider.cache.removeAll { $0.url.absoluteString == imageURL }
    }
    
    func removeAll() {
        ImageProvider.cache.removeAll()
    }
    
    private func cacheImage(imageURL: URL, image: UIImage) {
        let imageRecord = ImageRecord(url: imageURL, image: image)
        ImageProvider.cache.append(imageRecord)
    }
    
}

