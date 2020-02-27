//
//  TransactionsTableViewDelegate.swift
//  Transactions
//
//  Created by Mike on 27/02/2020.
//  Copyright © 2020 Mike Pollard. All rights reserved.
//

import UIKit

class TransactionsTableViewDelegate: NSObject {
    
    private weak var tableView: UITableView?
    private weak var transactionDelegate: TransactionRemoveButtonDelegate?
    
    init(tableView: UITableView, delegate: TransactionRemoveButtonDelegate) {
        super.init()
        
        tableView.register(UINib(nibName: TransactionConstants.transactionCell, bundle: .main), forCellReuseIdentifier: TransactionConstants.transactionCell)
        tableView.delegate = self

        self.tableView = tableView
        self.transactionDelegate = delegate
    }
}

extension TransactionsTableViewDelegate: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        transactionDelegate?.setButton(enabled: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard tableView.indexPathsForSelectedRows == nil else { return }
        transactionDelegate?.setButton(enabled: false)
    }
    
}
