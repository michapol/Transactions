//
//  TransactionsEditModeController.swift
//  Transactions
//
//  Created by Mike Pollard on 27/02/2020.
//  Copyright © 2020 Mike Pollard. All rights reserved.
//

import UIKit

class TransactionsEditModeController {
    
    private weak var tableView: UITableView?
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    private func unselectRows(indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            tableView?.deselectRow(at: indexPath, animated: true)
        }
    }
    
    private func getSelectedRows() -> [IndexPath] {
        return tableView?.indexPathsForSelectedRows ?? []
    }
    
}

extension TransactionsEditModeController: TransactionsEditModeDelegate {
    
    func removeSelected() {
        guard let dataSource = self.tableView?.dataSource as? TransactionsTableViewDataSource else { return }
        let selectedRows = getSelectedRows()
        dataSource.transactions?.removeSelected(selectedRows: selectedRows)
        tableView?.deleteRows(at: selectedRows, with: .automatic)
    }
    
    func configureTableView(edit: Bool) {
        tableView?.allowsMultipleSelection = edit
        if !edit {
            let selectedCells = getSelectedRows()
            unselectRows(indexPaths: selectedCells)
        }
    }

}
