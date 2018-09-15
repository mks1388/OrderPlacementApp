//
//  HistoryProduct.swift
//  OrderPlacementApp
//
//  Created by Mithilesh on 15/09/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation

struct HistoryProduct: Equatable {
    var product: Product
    var date: Date
    
    static func == (lhs: HistoryProduct, rhs: HistoryProduct) -> Bool {
        return lhs.product.name == rhs.product.name
    }
}
