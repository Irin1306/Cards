//
//  CoreDataStore.swift
//  Cards
//
//  Created by irina on 21.05.2020.
//  Copyright © 2020 irina. All rights reserved.
//

import Foundation
import CoreData

 

final class CoreDataStore {
    
    private init() {}
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    
    static var persistentContainer: NSPersistentContainer = {
     
        let container = NSPersistentContainer(name: "Cards")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
               //                fatalError("Unresolved error \(error), \(error.userInfo)")
                print(error)
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    static func saveContext (completionHandler: @escaping (Bool) -> Void) {
        
        let context = persistentContainer.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        if context.hasChanges {
            do {
                try context.save()
                DispatchQueue.main.async {
                    completionHandler (true)
                }
                 
            } catch {
               
                let nserror = error as NSError
                //                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                print(nserror)
                DispatchQueue.main.async {
                     completionHandler (false)
                     
                }
                 
            }
        }
        
    }
    
    static func fetchList<T: NSManagedObject>(_ objectType: T.Type, completionHandler: @escaping (() throws -> [T]) -> Void) {
 
        let entityName = String(describing: objectType)

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
          let fetchedObjects = try context.fetch(fetchRequest) as! [T]
           
          DispatchQueue.main.async {
            completionHandler { return fetchedObjects }
          }
        } catch {
          DispatchQueue.main.async {
            completionHandler { throw CoreDataStoreError.CannotFetch("Cannot fetch \(objectType)") }
          }
        }
    }
    
    static func fetchItem<T: NSManagedObject>(_ objectType: T.Type, number: String, completionHandler: @escaping (() throws -> T?) -> Void) {

        let entityName = String(describing: objectType)

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "cardNumber == %@", number)
        do {
           let fetchedObjects = try context.fetch(fetchRequest) as! [T]

           if let fetchedObject = fetchedObjects.first {
             DispatchQueue.main.async {
               completionHandler { return fetchedObject }
             }
           } else {
             DispatchQueue.main.async {
               completionHandler { throw CoreDataStoreError.CannotFetch("Cannot fetch item \(number)") }
             }
           }

        } catch {
           DispatchQueue.main.async {
               completionHandler { throw CoreDataStoreError.CannotFetch("Cannot fetch item \(number)") }
           }
       }

    }
    
    deinit
    {
      do {
        try CoreDataStore.context.save()
      } catch {
//        fatalError("Error deinitializing main managed object context")
        print("Error deinitializing main managed object context")
      }
    }
         
}

enum CoreDataStoreError: Error
{
  case CannotFetch(String)
  case CannotSave(String)
 
}
 
