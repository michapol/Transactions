//
//  TransactionDecoder.swift
//  Transactions
//
//  Created by Mike Pollard on 25/02/2020.
//  Copyright © 2020 Mike Pollard. All rights reserved.
//

import Foundation

struct TransactionDecoder {
    
    func decode(data: Data) -> Transactions? {
        let decoder = JSONDecoder()
        let transactions = try? decoder.decode(Transactions.self, from: data)
        return transactions
    }
    
}
