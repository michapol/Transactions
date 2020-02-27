//
//  Transactions.swift
//  Transactions
//
//  Created by Mike Pollard on 25/02/2020.
//  Copyright © 2020 Mike Pollard. All rights reserved.
//

import Foundation

class Transactions: Codable {
    
    var data: [TransactionData]
    
}

struct TransactionData: Codable {
    
    let id: String
    let date: String
    let description: String
    let category: String
    let currency: String
    let amount: TransactionAmount
    let product: TransactionProduct
    
}

struct TransactionAmount: Codable {
    
    let value: Double
    let currency_iso: String
    
}

struct TransactionProduct: Codable {
    
    let id: Int
    let title: String
    let icon: String
    
}

extension Transactions {
    
    func removeSelected(selectedRows: [IndexPath]) {
        let indices = selectedRows.map({ $0.row }).sorted(by: >)
        indices.forEach({ data.remove(at: $0) })
    }

}
