//
//  FavoriteService.swift
//  Pokupon
//
//  Created by Cat on 11/5/18.
//  Copyright © 2018 Cat. All rights reserved.
//

import Foundation
import CoreData

class FavoritesService: NSObject {
  
  static let shared = FavoritesService()
  
  func getFavoritsRepositories() -> NSFetchedResultsController<Repository> {
    let fetchRequest: NSFetchRequest<Repository> = Repository.fetchRequest()
    
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
    
    let result: NSFetchedResultsController = NSFetchedResultsController.init(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.getViewContext(), sectionNameKeyPath: nil, cacheName: nil)
    
    do {
      try result.performFetch()
    } catch {
      print("Error fetching favorites")
    }
    
    return result
  }
  
}
