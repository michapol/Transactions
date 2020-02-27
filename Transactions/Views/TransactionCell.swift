//
//  TransactionCell.swift
//  Transactions
//
//  Created by Mike Pollard on 25/02/2020.
//  Copyright © 2020 Mike Pollard. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var value: UILabel!
    
    @IBOutlet weak var keylineStub: UIView!
    
    override func awakeFromNib() {
        let selectedView = UIView()
        selectedView.backgroundColor = TransactionColours.lightRed
        self.selectedBackgroundView = selectedView
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        guard isSelected != selected else { return }
        super.setSelected(selected, animated: true)
        
        styleCell(selected: selected)
        styleImage(selected: selected)
    }
        
    override func prepareForReuse() {
        self.icon.image = nil
    }
    
    func setup(transaction: TransactionData) {
                
        let icon = transaction.product.icon
        ImageProvider().get(imageURL: icon) { (image) in
            DispatchQueue.main.async {
                self.icon.image = image
            }
        }
        
        desc.text = transaction.description
        category.text = transaction.category
        value.text = CurrencyFormatter().format(value: transaction.amount.value, as: transaction.amount.currency_iso)
        
    }
    
    func styleCell(selected: Bool) {
        desc.textColor = selected ? TransactionColours.darkRed : .black
        category.textColor = selected ? TransactionColours.darkRed : .black
        value.textColor = selected ? TransactionColours.darkRed : .black
        
        keylineStub.backgroundColor = selected ? .lightGray : .white
    }
    
    func styleImage(selected: Bool) {
        guard let image = icon.image else { return }
        let renderingMode: UIImage.RenderingMode = selected ? .alwaysTemplate : .alwaysOriginal
        let newImage = image.withRenderingMode(renderingMode)
        icon.image = newImage
        icon.tintColor = TransactionColours.darkRed
    }
    
    
}
