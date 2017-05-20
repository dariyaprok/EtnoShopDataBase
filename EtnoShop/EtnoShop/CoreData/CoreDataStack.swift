//
//  CoreDataManager.swift
//  EC-Play
//
//  Created by Dasha on 3/29/17.
//  Copyright © 2017 Basquare. All rights reserved.
//

import CoreData

final class CoreDataStack: NSObject {
    
    //MARK: - Properties

    private let modelName: String
    var memStore: NSPersistentStore?
    
    //MARK: - Core Data Stack
    
    private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("can't find data model")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("can't load from data model")
        }
        
        return managedObjectModel
    
    }()
    
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator: NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        //creating persistent store
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent("\(self.modelName).sqlite")
        let options = [NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption: true]
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreURL, options: options)
        } catch {
            print("Can't create persistentStore")
        }
        
        
        
        return persistentStoreCoordinator
    }()
    
    //MARK: - Initialization
    
    init(modelName: String) {
        self.modelName = modelName
    }
}
