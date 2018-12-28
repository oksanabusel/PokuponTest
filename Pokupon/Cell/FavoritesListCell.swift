//
//  FavoritesListCell.swift
//  Pokupon
//
//  Created by Cat on 11/5/18.
//  Copyright © 2018 Cat. All rights reserved.
//

import UIKit

class FavoritesListCell: UITableViewCell {
  
  @IBOutlet weak var repositoryNameLabel: UILabel!
  @IBOutlet weak var starsQuantityLabel: UILabel!
  
  func setData(data: Repository) {
    repositoryNameLabel.text = data.name
    starsQuantityLabel.text = data.repositoryStars?.stringValue
  }
  
}
