//
//  TransactionsTableViewDataSource.swift
//  Transactions
//
//  Created by Mike on 27/02/2020.
//  Copyright © 2020 Mike Pollard. All rights reserved.
//

import UIKit

class TransactionsTableViewDataSource: NSObject {
    
    private weak var tableView: UITableView?
    
    var transactions: Transactions?

    init(transactions: Transactions?, tableView: UITableView) {
        super.init()

        self.transactions = transactions
        self.tableView = tableView

        tableView.dataSource = self
        tableView.reloadData()
    }
}

extension TransactionsTableViewDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionConstants.transactionCell, for: indexPath)
        
        if let transactionCell = cell as? TransactionCell, let data = transactions?.data, data.count > indexPath.row {
            transactionCell.setup(transaction: data[indexPath.row])
        }
        
        return cell
    }

}
