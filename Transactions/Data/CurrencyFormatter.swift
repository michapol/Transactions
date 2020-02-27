//
//  CurrencyFormatter.swift
//  Transactions
//
//  Created by Mike Pollard on 26/02/2020.
//  Copyright © 2020 Mike Pollard. All rights reserved.
//

import Foundation

struct CurrencyFormatter {
    
    func format(value: Double, as currency: String) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        
        let formattedValue = formatter.string(from: value as NSNumber)
        return formattedValue ?? "\(value)"
    }
    
}
