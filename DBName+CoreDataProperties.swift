//
//  DBName+CoreDataProperties.swift
//  matchmate
//
//  Created by Vaibhav Bhatt on 13/07/24.
//
//

import Foundation
import CoreData


extension DBName {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBName> {
        return NSFetchRequest<DBName>(entityName: "DBName")
    }

    @NSManaged public var first: String?
    @NSManaged public var last: String?
    @NSManaged public var title: String?
    @NSManaged public var matches: DBMatch?

}

extension DBName : Identifiable {

}
