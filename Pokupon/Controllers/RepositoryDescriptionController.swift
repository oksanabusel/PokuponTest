//
//  RepositoryDescriptionController.swift
//  Pokupon
//
//  Created by Cat on 11/5/18.
//  Copyright © 2018 Cat. All rights reserved.
//

import UIKit
import CoreData

class RepositoryDescriptionController: UIViewController {
  
  @IBOutlet weak var repositoryNameLabel: UILabel!
  @IBOutlet weak var repositoryLanguageLabel: UILabel!
  @IBOutlet weak var repositoryStarsQuantity: UILabel!
  @IBOutlet weak var repositoryDescriptionLabel: UILabel!
  @IBOutlet weak var addToFavoritesButton: UIButton!
  @IBOutlet weak var removeFromFavoritesButton: UIButton!
  
  var data: RepositoryDataModel?
  var favoriteRepositoryData: Repository?
  var fetchedResultController: NSFetchedResultsController<Repository>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if data != nil {
      repositoryNameLabel.text = data?.name
      repositoryLanguageLabel.text = data?.language ?? "-"
      repositoryStarsQuantity.text = String(data?.stars ?? 0)
      repositoryDescriptionLabel.text = data?.description
      
      if isUnique() == false {
        addToFavoritesButton.isEnabled = false
        removeFromFavoritesButton.isEnabled = true
      }
    }
    
    if favoriteRepositoryData != nil {
      addToFavoritesButton.isEnabled = false
      repositoryNameLabel.text = favoriteRepositoryData?.name
      repositoryLanguageLabel.text = favoriteRepositoryData?.language ?? "-"
      repositoryDescriptionLabel.text = favoriteRepositoryData?.repositoryDescription
      repositoryStarsQuantity.text = favoriteRepositoryData?.repositoryStars?.stringValue
    }
  }
  
  @IBAction func tapAddToFavoritesButton(_ sender: Any) {
    let saveContext = CoreDataStack.shared.getViewContext()
    
    if data != nil {
      let newFavoriteRepository = Repository(context: saveContext)
      newFavoriteRepository.id = (data?.Id ?? 0) as NSNumber
      newFavoriteRepository.language = data?.language
      newFavoriteRepository.name = data?.name
      newFavoriteRepository.repositoryStars = (data?.stars ?? 0) as NSNumber
      newFavoriteRepository.isFavorite = true
      newFavoriteRepository.id = (data?.Id ?? 0) as NSNumber
      CoreDataStack.shared.saveContext()
      addToFavoritesButton.isEnabled = false
      removeFromFavoritesButton.isEnabled = true
    }
  }
  
  @IBAction func tapRemoveFromFavoritesButton(_ sender: Any) {
    if data != nil {
      let saveContext = CoreDataStack.shared.getBackgroundCOntext()
      let fetchRequest: NSFetchRequest<Repository> = Repository.fetchRequest()
      
      do {
        let fetchedObjects = try saveContext.fetch(fetchRequest)
        let repositoryId = Int(data!.Id!)
        
        for object in fetchedObjects {
          if object.id?.intValue == repositoryId {
            saveContext.delete(object)
            try saveContext.save()
          }
        }
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
      addToFavoritesButton.isEnabled = true
      
    } else if favoriteRepositoryData != nil {
      favoriteRepositoryData?.isFavorite = false
      
      guard let repoId = favoriteRepositoryData?.id else { return }
      
      let saveContext = CoreDataStack.shared.getBackgroundCOntext()
      let fetchRequest: NSFetchRequest<Repository> = Repository.fetchRequest()
      
      do {
        let fetchedObjects = try saveContext.fetch(fetchRequest)
        let repositoryId = Int(truncating: repoId)
        
        for object in fetchedObjects {
          if object.id?.intValue == repositoryId {
            saveContext.delete(object)
            try saveContext.save()
            removeFromFavoritesButton.isEnabled = false
          }
        }
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
    self.navigationController?.popViewController(animated: true)
  }
  
  func isUnique() -> Bool {
    self.fetchedResultController = FavoritesService.shared.getFavoritsRepositories()
    
    for item in fetchedResultController.fetchedObjects as! [Repository] {
      let repositoryId = (data?.Id ?? 0) as NSNumber
      let fetchedRepositoryId = item.id
      
      if repositoryId == fetchedRepositoryId {
        return false
      }
    }
    removeFromFavoritesButton.isEnabled = false
    return true
  }
  
}
