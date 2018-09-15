//
//  HistoryProductCell.swift
//  OrderPlacementApp
//
//  Created by Mithilesh on 15/09/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import UIKit

class HistoryProductCell: UITableViewCell {
    
    static let Identifier = "history_product_cell"
    
    func configure(with cartProduct: HistoryProduct) {
        textLabel?.text = cartProduct.product.name
        detailTextLabel?.text = "Rs. \(cartProduct.product.cost)"
    }
}
