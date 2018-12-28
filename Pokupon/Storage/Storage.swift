//
//  Storage.swift
//  Pokupon
//
//  Created by Cat on 11/5/18.
//  Copyright © 2018 Cat. All rights reserved.
//

import Foundation

class Storage {
  
  static var shared = Storage()
  
  var repositoryComponents: [RepositoryDataModel] = []
  
  private init() {}
  
}
