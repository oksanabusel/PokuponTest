//
//  RepositoryListCell.swift
//  Pokupon
//
//  Created by Cat on 11/5/18.
//  Copyright © 2018 Cat. All rights reserved.
//

import UIKit

class RepositoryListCell: UITableViewCell {
  @IBOutlet weak var repositoryNameLabel: UILabel!
  @IBOutlet weak var starImage: UIImageView!
  @IBOutlet weak var starsQuantityLabel: UILabel!
  
  func setData(data: RepositoryDataModel) {
    repositoryNameLabel.text = data.name
    starsQuantityLabel.text = String(data.stars!)
  }
  
}
