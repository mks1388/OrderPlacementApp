//
//  HistoryViewController.swift
//  OrderPlacementApp
//
//  Created by Mithilesh on 15/09/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class HistoryViewController: UIViewController {
    
    private struct Constant {
        static let title = "History"
    }
    
    @IBOutlet private var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        title = Constant.title
        
        let observable = Observable.just(ShoppingCart.shared.getHistoryProducts())
        setupCellConfiguration(observable)
    }
    
    //MARK : private methods
    
    private func setupCellConfiguration(_ observable: Observable<[HistoryProduct]>) {
        observable.bind(to: self.tableView.rx.items(cellIdentifier: HistoryProductCell.Identifier, cellType: HistoryProductCell.self)) {(row, product, cell) in
            cell.configure(with:product)
            }.disposed(by: self.disposeBag)
    }
}
