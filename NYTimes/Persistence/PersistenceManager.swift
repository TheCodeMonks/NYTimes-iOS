//
//  PersistanceManager.swift
//  NYTimes
//
//  Created by Waseem Akram on 29/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import CoreData

/// PersistenceManager is a Singleton which manages the
/// coredata core operations like creating containers, context and handles saving of the data
final class PersistenceManager {
    
    private init(){}
    
    static let shared = PersistenceManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NYTimes")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext

    func saveContext () -> Bool {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                debugPrint(nserror)
                return false
            }
            return true
        }
        return false
    }
    
    func fetch<T:NSManagedObject>(managedObject: T.Type) -> [T]? {
        do {
            guard let result = try PersistenceManager.shared.context.fetch(managedObject.fetchRequest()) as? [T] else {
                return nil
            }
            
            return result
        }catch let error {
            debugPrint(error)
            return nil
        }
    }
    
}
