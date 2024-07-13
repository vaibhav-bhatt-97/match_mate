//
//  DBMatch+CoreDataProperties.swift
//  matchmate
//
//  Created by Vaibhav Bhatt on 13/07/24.
//
//

import Foundation
import CoreData


extension DBMatch {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBMatch> {
        return NSFetchRequest<DBMatch>(entityName: "DBMatch")
    }

    @NSManaged public var accepted: String?
    @NSManaged public var cell: String?
    @NSManaged public var email: String?
    @NSManaged public var gender: String?
    @NSManaged public var id: UUID?
    @NSManaged public var nat: String?
    @NSManaged public var phone: String?
    @NSManaged public var timeStamp: Date?
    @NSManaged public var location: DBLocation?
    @NSManaged public var name: DBName?
    @NSManaged public var picture: DBPicture?

}

extension DBMatch : Identifiable {

}
