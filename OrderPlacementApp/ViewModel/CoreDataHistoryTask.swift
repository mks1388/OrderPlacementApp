//
//  CoreDataHistoryTask.swift
//  OrderPlacementApp
//
//  Created by Mithilesh on 15/09/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHistoryTask {
   
    private struct Constant {
        static let historyEntity = "History"
    }
    
    func addProductsToHistory(productArr:[Product], context: NSManagedObjectContext) {
        context.performAndWait {[weak self] in
            let date = Date()
            for item in productArr {
                self?.addHistoryObject(item, date:date, context: context)
            }
        }
    }
    
    func fetchHistory(context: NSManagedObjectContext) -> [HistoryProduct] {
        var arr = [HistoryProduct]()
        let fetchReq : NSFetchRequest<History> = History.fetchRequest()
        context.performAndWait {
            do {
                let fetchResults = try context.fetch(fetchReq)
                for result in fetchResults {
                    let cost = Int(result.cost)
                    if let name = result.name, let date = result.date {
                        let product = Product(name: name, cost: cost)
                        let historyProduct = HistoryProduct(product: product, date: date)
                        arr.append(historyProduct)
                    }
                }
            } catch {
            }
        }
        return arr.reversed()
    }
    
    //MARK: private methods
    
    private func addHistoryObject(_ product: Product, date: Date, context: NSManagedObjectContext) {
        let history = NSEntityDescription.insertNewObject(forEntityName: Constant.historyEntity, into: context) as? History
        history?.name = product.name
        history?.cost = Int64(product.cost)
        history?.date = date
    }
}
