//
//  Product.swift
//  OrderPlacementApp
//
//  Created by Mithilesh on 14/09/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation

struct ProductList:Codable {    
    var products:[Product]
}

struct Product: Codable, Equatable {
    var name:String
    var cost:Int
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.name == rhs.name
    }
}
