//
//  FavoritesRepositoriesController.swift
//  Pokupon
//
//  Created by Cat on 11/5/18.
//  Copyright © 2018 Cat. All rights reserved.
//

import UIKit
import CoreData

class FavoritesRepositoriesController: UIViewController {
  
  @IBOutlet weak var favoritesListTable: UITableView!
  
  var fetchedResultController: NSFetchedResultsController<Repository>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.fetchedResultController = FavoritesService.shared.getFavoritsRepositories()
    self.favoritesListTable.reloadData()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destination = segue.destination as? RepositoryDescriptionController, let dataIndex =
      favoritesListTable.indexPathForSelectedRow?.row {
      destination.favoriteRepositoryData = fetchedResultController.fetchedObjects?[dataIndex]
    }
  }
  
}

extension FavoritesRepositoriesController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fetchedResultController.fetchedObjects?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FavoritesListCell
    let repositoryData = fetchedResultController.object(at: indexPath)
    cell.setData(data: repositoryData)
    
    return cell
  }
  
}
