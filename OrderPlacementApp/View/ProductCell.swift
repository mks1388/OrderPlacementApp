//
//  ProductCell.swift
//  OrderPlacementApp
//
//  Created by Mithilesh on 15/09/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation
import UIKit

class ProductCell: UITableViewCell {
    
    static let Identifier = "product_cell"
    
    func configure(withProduct product: Product) {
        self.textLabel?.text = product.name
        self.detailTextLabel?.text = "Rs. \(product.cost)"
    }
}
