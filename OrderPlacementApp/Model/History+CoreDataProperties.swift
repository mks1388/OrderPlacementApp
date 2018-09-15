//
//  History+CoreDataProperties.swift
//  
//
//  Created by Mithilesh on 15/09/18.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var cost: Int64
    @NSManaged public var date: NSDate?
    @NSManaged public var name: String?

}
