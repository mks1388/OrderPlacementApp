//
//  CartProduct.swift
//  OrderPlacementApp
//
//  Created by Mithilesh on 15/09/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation

struct CartProduct : Equatable {
    
    var product:Product
    var date:Date
    
    static func == (lhs: CartProduct, rhs: CartProduct) -> Bool {
        return lhs.product.name == rhs.product.name
    }
}
