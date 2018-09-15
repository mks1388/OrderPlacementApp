//
//  CartViewController.swift
//  OrderPlacementApp
//
//  Created by Mithilesh on 15/09/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class CartViewController: UIViewController {
    
    private struct Constant {
        static let title = "Cart"
    }
    
    @IBOutlet private var successMessageBottomconstraint: NSLayoutConstraint!
    
    @IBOutlet private var checkoutButton: UIButton!
    @IBOutlet private var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        title = Constant.title
        
        let observable = Observable.just(ShoppingCart.shared.cartProducts.value)
        setupCellConfiguration(observable)
        setupCheckoutButton()
    }
    
    @IBAction func checkoutProduct(_ sender: UIButton) {
        successMessageBottomconstraint.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }, completion: { (complete) in
            ShoppingCart.shared.addCartProductsToHistory()
            ShoppingCart.shared.removeAllProductsFromCart()
        })
    }
    
    //MARK: private methods
    
    private func setupCellConfiguration(_ observable: Observable<[CartProduct]>) {
        observable.bind(to: self.tableView.rx.items(cellIdentifier: CartProductCell.Identifier, cellType: CartProductCell.self)) {(row, product, cell) in
            cell.configure(with:product)
            }.disposed(by: self.disposeBag)
    }
    
    private func setupCheckoutButton() {
        self.checkoutButton.isUserInteractionEnabled = ShoppingCart.shared.cartProducts.value.count > 0
        self.checkoutButton.alpha = self.checkoutButton.isUserInteractionEnabled ? 1.0 : 0.4
        if ShoppingCart.shared.cartProducts.value.count > 0 {
            let sum = ShoppingCart.shared.cartProducts.value.map({$0.product.cost}).reduce(0, +)
            let title = "Checkout (Rs. \(sum))"
            self.checkoutButton.setTitle(title, for: UIControl.State.normal)
        }
    }
}
