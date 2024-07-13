//
//  DBPicture+CoreDataProperties.swift
//  matchmate
//
//  Created by Vaibhav Bhatt on 13/07/24.
//
//

import Foundation
import CoreData


extension DBPicture {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBPicture> {
        return NSFetchRequest<DBPicture>(entityName: "DBPicture")
    }

    @NSManaged public var large: String?
    @NSManaged public var medium: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var matches: DBMatch?

}

extension DBPicture : Identifiable {

}
