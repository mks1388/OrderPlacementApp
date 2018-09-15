//
//  ProductViewModel.swift
//  OrderPlacementApp
//
//  Created by Mithilesh on 14/09/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct ProductViewModel {
    
    func updateProductList(_ completion: @escaping ([Product]) -> Void) {
        ProductClient.shared.getAllProductList { (data) in
            guard let data = data else {
                completion([Product]())
                return
            }
            
            do {
                let productList = try JSONDecoder().decode(ProductList.self, from: data)
                completion(productList.products)
            } catch {
                completion([Product]())
            }
        }
    }
}
