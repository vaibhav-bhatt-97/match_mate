//
//  DBNetworkTimeStamp+CoreDataProperties.swift
//  matchmate
//
//  Created by Vaibhav Bhatt on 13/07/24.
//
//

import Foundation
import CoreData


extension DBNetworkTimeStamp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBNetworkTimeStamp> {
        return NSFetchRequest<DBNetworkTimeStamp>(entityName: "DBNetworkTimeStamp")
    }

    @NSManaged public var timeStamp: Date?
    @NSManaged public var isDataSynchronized: Bool

}

extension DBNetworkTimeStamp : Identifiable {

}
