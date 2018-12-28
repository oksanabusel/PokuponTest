//
//  Strings.swift
//  Pokupon
//
//  Created by Cat on 11/5/18.
//  Copyright © 2018 Cat. All rights reserved.
//

import Foundation

enum PaginationParameters: String {
  case page = "page"
  case perPage = "per_page"
  case resultsPerPage = "10"
}

enum URLparameters: String {
  case urlText = "https://api.github.com/users/"
  case repositoriesParam = "/repos"
}

enum ErrorMessages: String {
  case errorConvertToJson = "Error trying to convert data to JSON"
  case errorFailUrl = "Error: cannot create url!"
  case errorDidintReseiveData = "Didn't receive data!"
  case errorCannotSaveContext = "Failure to save context:"
}
