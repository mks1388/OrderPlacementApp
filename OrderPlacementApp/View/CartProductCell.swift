//
//  CartProductCell.swift
//  OrderPlacementApp
//
//  Created by Mithilesh on 15/09/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import UIKit

class CartProductCell: UITableViewCell {
    static let Identifier = "cart_product_cell"
    
    func configure(with product: Product) {
        textLabel?.text = product.name
        detailTextLabel?.text = "Rs. \(product.cost)"
    }
}
