//
//  DBLocation+CoreDataProperties.swift
//  matchmate
//
//  Created by Vaibhav Bhatt on 13/07/24.
//
//

import Foundation
import CoreData


extension DBLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBLocation> {
        return NSFetchRequest<DBLocation>(entityName: "DBLocation")
    }

    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var state: String?
    @NSManaged public var matches: DBMatch?

}

extension DBLocation : Identifiable {

}
