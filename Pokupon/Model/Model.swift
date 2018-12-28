//
//  Model.swift
//  Pokupon
//
//  Created by Cat on 11/5/18.
//  Copyright © 2018 Cat. All rights reserved.
//

import UIKit

struct RepositoryDataModel: Codable {
  var name: String?
  var language: String?
  var description: String?
  var stars: Int?
  var Id: Int?
  var isFavorite: Bool?
  
  init(name: String, language: String, description: String, stars: Int, Id: Int) {
    self.name = name
    self.language = language
    self.description = description
    self.stars = stars
    self.Id = Id
  }
  
  enum CodingKeys: String, CodingKey {
    case name = "name"
    case language = "language"
    case description = "description"
    case stars = "stargazers_count"
    case Id = "id"
  }
  
}
