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

struct Product: Codable {
    var name:String
    var cost:Int
}
