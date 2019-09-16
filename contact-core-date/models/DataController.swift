//
//  DataController.swift
//  contact-core-date
//
//  Created by Thet Htun on 9/15/19.
//  Copyright © 2019 padc. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    
    static let shared = DataController(modelName: "contact")
    
    var persistentContainer : NSPersistentContainer? = nil
    
    var viewContext : NSManagedObjectContext? {
        return persistentContainer?.viewContext
    }
    
    private init(modelName : String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer?.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if error != nil {
                fatalError(error!.localizedDescription)
            }
            
            completion?()
        })
    }
}
