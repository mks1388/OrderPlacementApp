//
//  ViewController.swift
//  OrderPlacementApp
//
//  Created by Mithilesh on 14/09/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet private var cartItem: UIBarButtonItem!
    @IBOutlet private var historyItem: UIBarButtonItem!
    @IBOutlet private var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    private var viewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.updateProductList { (productArr) in
            let observable = Observable.just(productArr)
            self.setupCellConfiguration(observable)
        }
        setupCellTabHandling()
        setupCartObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        cartItem.addBadge()
    }
    
    
    //MARK: private methods
    
    private func setupCartObserver() {
        ShoppingCart.shared.cartProducts.asObservable().subscribe { (products) in
            self.updateCart()
        }.disposed(by: disposeBag)
    }
    
    private func updateCart() {
        cartItem.updateBadgecount(count: ShoppingCart.shared.cartProducts.value.count)
    }
    
    private func setupCellConfiguration(_ observable: Observable<[Product]>) {
        DispatchQueue.main.async {
            observable.bind(to: self.tableView.rx.items(cellIdentifier: ProductCell.Identifier, cellType: ProductCell.self)) {(row, product, cell) in
                cell.configure(withProduct:product)
                }.disposed(by: self.disposeBag)
        }
    }
    
    private func setupCellTabHandling() {
        tableView.rx.modelSelected(Product.self).subscribe(onNext: { (product) in
            guard let indexPath = self.tableView.indexPathForSelectedRow, let window = UIApplication.shared.keyWindow, let cartView = self.cartItem.value(forKey: "view") as? UIView else {
                return
            }
            self.tableView.deselectRow(at: indexPath, animated: true)
            let cell = self.tableView.cellForRow(at: indexPath) as! ProductCell

            if let textLabel = cell.textLabel {
                let point = textLabel.convert(textLabel.bounds.origin, to: window)
                let label = UILabel(frame: CGRect(x: point.x, y: point.y, width: textLabel.bounds.width, height: textLabel.bounds.height))
                label.text = textLabel.text
                
                let cartPoint = cartView.convert(cartView.frame.origin, to: nil)
                let center = CGPoint(x: cartPoint.x + cartView.frame.size.width/2, y: cartPoint.y + cartView.frame.size.height/2)
                label.applyAddToCartAnimation(parentView: window, to: center, {
                    ShoppingCart.shared.addProductToCart(product)
                })
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
}

