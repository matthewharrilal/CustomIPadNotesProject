//
//  CoreDataStack.swift
//  IpadNotesProject
//
//  Created by Matthew Harrilal on 3/3/18.
//  Copyright © 2018 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class CoreDataStack {
    
    // By doing this we are creating a singleton making this the only instantiation of this class we are creatin glorified globals one day at a time
    static let coreDataStack = CoreDataStack()
    
    // Creating the perisistent container that holds the responsibilities of sending the managed objects from the context to the persistent store which is sqlite by default
    private lazy var persistentContainer:NSPersistentContainer = {
        let container = NSPersistentContainer(name: "IpadNotesProject")
        
        container.loadPersistentStores(completionHandler: { (completionHandler, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error.localizedDescription))")
            }
        })
        return container
    }()
    
    lazy var viewContext:NSManagedObjectContext = {
        // Essentially what we are doing here is that we are creating the view context so that are tasks
        // can perform on the main queue
        let viewContext = persistentContainer.viewContext
        viewContext.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return viewContext
    }()
    
    lazy var privateContext: NSManagedObjectContext = {
        // Essentially what we are doing here is that we are creating the private context so that are tasks can perform on the background context
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return privateContext
    }()
    
    // We are essentially using this function to save objects to the context this is basically our save game function
    func saveTo(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                print("The changes were saved to the context succesfully")
                try context.save()
            }
            catch {
                let error = error as NSError?
                fatalError("Objects could not be saved \(error?.localizedDescription)")
            }
        }
    }
}
