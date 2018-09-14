//
//  ProductViewModel.swift
//  OrderPlacementApp
//
//  Created by Mithilesh on 14/09/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation

struct ProductViewModel {
    
    var productArr:[Product]?
    
    mutating func updateProductList() {
        
        var currentSelf = self
        
        ProductClient.shared.getAllProductList { (data) in
            guard let data = data else {
                currentSelf.productArr = nil
                return
            }
            
            do {
                let productList = try JSONDecoder().decode(ProductList.self, from: data)
                currentSelf.productArr = productList.products
            } catch {
                currentSelf.productArr = nil
            }
        }
    }
}
