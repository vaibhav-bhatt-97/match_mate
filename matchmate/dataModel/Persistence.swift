//
//  Persistence.swift
//  matchmate
//
//  Created by Vaibhav Bhatt on 11/07/24.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()


    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "matchmate")

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("ERROR:- ",error.userInfo)
//                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        func saveContext() {
            let context = container.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
        
    }
}
