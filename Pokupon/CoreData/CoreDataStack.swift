//
//  CoreDataStack.swift
//  Pokupon
//
//  Created by Cat on 11/5/18.
//  Copyright © 2018 Cat. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
  
  static var shared = CoreDataStack()
  
  private var backgroundContext: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
  
  func getViewContext() -> NSManagedObjectContext {
    let context = storeContainer.viewContext
    
    return context
  }
  
  func getBackgroundCOntext() -> NSManagedObjectContext {
  backgroundContext.parent = storeContainer.viewContext
    
  return backgroundContext
  }
  
  var storeContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Model")
    container.loadPersistentStores {
      (storeDescription, error) in
      if let error = error as NSError? {
        print("Unresolved error\(error), \(error.userInfo)")
      }
    }
    return container
  }()
  
  func saveContext () {
    guard storeContainer.viewContext.hasChanges else { return }
    do {
      try storeContainer.viewContext.save()
    } catch let error as NSError {
      print("Unresolved error \(error), \(error.userInfo)")
    }
  }
  
  private init() {}
}
