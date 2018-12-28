//
//  RepositoryListController.swift
//  Pokupon
//
//  Created by Cat on 11/5/18.
//  Copyright © 2018 Cat. All rights reserved.
//

import UIKit
import CoreData

class RepositoryListController: UIViewController {
  @IBOutlet weak var repositoryListTable: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  private var currentPage: Int = 1
  private var sholdRequestMoreData: Bool = true
  
  var fetchedResultController: NSFetchedResultsController<Repository>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.fetchedResultController = FavoritesService.shared.getFavoritsRepositories()
    repositoryListTable.reloadData()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destination = segue.destination as? RepositoryDescriptionController, let dataIndex = repositoryListTable.indexPathForSelectedRow?.row {
      destination.data = Storage.shared.repositoryComponents[dataIndex]
    }
  }
  
  func loadMoreData() {
    self.currentPage += 1
    
    let request = Request()
    
    let searchBarText = searchBar.text ?? ""
    let completeSearchString = searchBarText
    
    request.sendRequest(urlString: completeSearchString, page: self.currentPage) { moreDataAvailable in
      self.sholdRequestMoreData = moreDataAvailable
      
      DispatchQueue.main.async {
        self.repositoryListTable.reloadData()
      }
    }
  }
  
}

extension RepositoryListController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Storage.shared.repositoryComponents.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RepositoryListCell
    
    cell.setData(data: Storage.shared.repositoryComponents[indexPath.row])
    
    if indexPath.row == Storage.shared.repositoryComponents.count - 1 && self.sholdRequestMoreData {
      loadMoreData()
    }
    
    return cell
  }
  
}

extension RepositoryListController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    Storage.shared.repositoryComponents = []
    
    let request = Request()
    
    searchBar.resignFirstResponder()
    
    let searchBarText = searchBar.text ?? ""
    let completeSearchString = searchBarText
    
    request.sendRequest(urlString: completeSearchString, completion: { moreDataAvailable in
      self.sholdRequestMoreData = moreDataAvailable
      
      DispatchQueue.main.async {
        self.repositoryListTable.reloadData()
      }
    })
  }
  
}
