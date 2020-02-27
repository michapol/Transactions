//
//  ImageRecord.swift
//  Transactions
//
//  Created by Mike Pollard on 25/02/2020.
//  Copyright © 2020 Mike Pollard. All rights reserved.
//

import UIKit

struct ImageRecord {
    
    var url: URL
    var image: UIImage
    
    init(url: URL, image: UIImage) {
        self.url = url
        self.image = image
    }
}
