//
//  TransactionsEditModeDelegate.swift
//  Transactions
//
//  Created by Mike Pollard on 27/02/2020.
//  Copyright © 2020 Mike Pollard. All rights reserved.
//

import Foundation

protocol TransactionsEditModeDelegate {
    func removeSelected()
    func configureTableView(edit: Bool)
}
