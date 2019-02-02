//
//  Core.swift
//  Funny
//
//  Created by Robby Klein on 1/31/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import Foundation
import CoreData

class Core {
    // Only one instance allowed
    private init() {}
    
    // Create singleton
    static var context:NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: Methods from AppDelegate
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Funny")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("saved!")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
