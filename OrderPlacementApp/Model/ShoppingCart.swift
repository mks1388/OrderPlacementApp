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
    
    var cartProducts: BehaviorRelay<[Product]> = BehaviorRelay(value: [Product]())
    private var historyProducts: BehaviorRelay<[HistoryProduct]> = BehaviorRelay(value: [HistoryProduct]())
    
    private init() {
        historyProducts.accept(CoreDataManager.shared.fetchHistory())
    }
    
    func addProductToCart(_ product: Product) {
        ShoppingCart.shared.cartProducts.accept(ShoppingCart.shared.cartProducts.value + [product])
    }
    
    func removeAllProductsFromCart() {
        ShoppingCart.shared.cartProducts.accept([])
    }
    
    func addCartProductsToHistory() {
        CoreDataManager.shared.addProductsToHistory(productArr: ShoppingCart.shared.cartProducts.value)
        var products = [HistoryProduct]()
        let date = Date()
        for product in ShoppingCart.shared.cartProducts.value {
            let historyProduct = HistoryProduct(product: product, date: date)
            products.append(historyProduct)
        }
        ShoppingCart.shared.historyProducts.accept(products + ShoppingCart.shared.historyProducts.value)
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
    
    func getHistoryProducts() -> [HistoryProduct] {
        removeStaleProductsFromHistory()
        return ShoppingCart.shared.historyProducts.value
    }
}
