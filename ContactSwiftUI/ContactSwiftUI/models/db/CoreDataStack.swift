//
//  CoreDataStack.swift
//  padc-calculator-swift-ui
//
//  Created by Thet Htun on 5/13/20.
//  Copyright © 2020 thethtun. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    private init() {}
    
    var persistentContainer : NSPersistentContainer = appDelegate.persistentContainer
    
    var viewContext : NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}
