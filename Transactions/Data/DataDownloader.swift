//
//  DataDownloader.swift
//  Transactions
//
//  Created by Mike Pollard on 25/02/2020.
//  Copyright © 2020 Mike Pollard. All rights reserved.
//

import Foundation

struct DataDownloader {
    
    func download(url: String, completion: @escaping (Data?)->()) {
        guard let url = URL(string: url) else { completion(nil); return }
        download(url: url, completion: completion)
    }
    
    func download(url: URL, completion: @escaping (Data?)->()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                completion(data)
            } else {
                print("An error occurred downloading the data: \(error?.localizedDescription ?? "Unknown")")
                completion(nil)
            }
        }.resume()
    }
    
}
