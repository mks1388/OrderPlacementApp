//
//  CoreDataManager.swift
//  OrderPlacementApp
//
//  Created by Mithilesh on 15/09/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    private struct Constant {
        static let storeName = "OrderPlacementApp"
    }
    
    static let shared = CoreDataManager()
    
    private let historyTask = CoreDataHistoryTask()
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constant.storeName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    lazy var childContext:NSManagedObjectContext = {
        let nContext : NSManagedObjectContext = self.persistentContainer.newBackgroundContext()
        nContext.automaticallyMergesChangesFromParent = true
        return nContext
    }()
    
    // MARK: - Core Data Saving support
    
    func addProductsToHistory(productArr:[Product]) {
        historyTask.addProductsToHistory(productArr: productArr, context: CoreDataManager.shared.childContext)
        saveChildContext()
    }
    
    func fetchHistory() -> [HistoryProduct] {
        return historyTask.fetchHistory(context:CoreDataManager.shared.childContext)
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("error detected")
            }
        }
    }
    
    func saveChildContext() {
        childContext.performAndWait {
            if  childContext.hasChanges {
                do {
                    try childContext.save()
                } catch {
                }
            }
        }
    }
}
