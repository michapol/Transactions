//
//  TransactionsViewController.swift
//  Transactions
//
//  Created by Mike Pollard on 25/02/2020.
//  Copyright © 2020 Mike Pollard. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var removeButtonHeight: NSLayoutConstraint!
    
    var editMode: Bool = false
    
    var tableViewDelegate: TransactionsTableViewDelegate?
    var tableViewDataSource: TransactionsTableViewDataSource?
    var editModeDelegate: TransactionsEditModeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTransactions(url: TransactionConstants.endPoint) { (transactions) in
            self.setupTableView(transactions: transactions)
            self.editModeDelegate = TransactionsEditModeController(tableView: self.tableView)
        }
    }
    
    private func getTransactions(url: String, completion: @escaping (Transactions?)->()) {
        DataDownloader().download(url: url) { (data) in
            if let data = data {
                let transactions = TransactionDecoder().decode(data: data)
                completion(transactions)
            }
        }
    }
    
    private func setupTableView(transactions: Transactions?) {        
        DispatchQueue.main.async {
            self.tableViewDelegate = TransactionsTableViewDelegate(tableView: self.tableView, delegate: self)
            self.tableViewDataSource = TransactionsTableViewDataSource(transactions: transactions, tableView: self.tableView)
        }
    }
    
    private func presentButton(show: Bool) {
        setButton(enabled: false)
        removeButtonHeight.constant = show ? TransactionConstants.removeButtonHeight : 0.0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
        
    @IBAction func editTapped(_ sender: UIBarButtonItem) {
        self.editMode.toggle()
        sender.title = self.editMode ? "Done" : "Edit"
        editModeDelegate?.configureTableView(edit: self.editMode)
        presentButton(show: self.editMode)
    }
    
    @IBAction func removeTapped() {
        editModeDelegate?.removeSelected()
        setButton(enabled: false)
    }
}

extension TransactionViewController: TransactionRemoveButtonDelegate {
    
    func setButton(enabled: Bool) {
        removeButton.backgroundColor = enabled ? TransactionColours.darkRed : .lightGray
    }
    
}

