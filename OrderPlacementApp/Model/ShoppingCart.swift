//
//  ShoppingCart.swift
//  OrderPlacementApp
//
//  Created by Mithilesh on 15/09/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ShoppingCart {
    
    static let shared = ShoppingCart()
    
    var cartProducts: BehaviorRelay<[CartProduct]> = BehaviorRelay(value: [CartProduct]())
    private var historyProducts: BehaviorRelay<[CartProduct]> = BehaviorRelay(value: [CartProduct]())
    
    func addProductToCart(_ product: Product) {
        let cartProduct = CartProduct(product: product, date: Date())
        ShoppingCart.shared.cartProducts.accept(ShoppingCart.shared.cartProducts.value + [cartProduct])
    }
    
    func removeAllProductsFromCart() {
        ShoppingCart.shared.cartProducts.accept([])
    }
    
    func addCartProductsToHistory() {
        ShoppingCart.shared.historyProducts.accept(ShoppingCart.shared.historyProducts.value + ShoppingCart.shared.cartProducts.value)
    }
    
    func removeStaleProductsFromHistory() {
        let products = ShoppingCart.shared.historyProducts.value.filter {
            if let historyDate = Calendar.current.date(byAdding: Calendar.Component.day, value: -3, to: Date()) {
                return $0.date > historyDate
            }
            return false
        }
        ShoppingCart.shared.historyProducts.accept(products)
    }
    
    func getHistoryProducts() -> [CartProduct] {
        removeStaleProductsFromHistory()
        return ShoppingCart.shared.historyProducts.value
    }
}
