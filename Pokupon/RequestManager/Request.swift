//
//  Request.swift
//  Pokupon
//
//  Created by Cat on 11/5/18.
//  Copyright © 2018 Cat. All rights reserved.
//

import UIKit
import Foundation

class Request: NSObject {
  
  func sendRequest(urlString: String, page: Int = 1, completion: @escaping (_ moreDataAvaliable: Bool) -> Void) {
    let completeUrlString = URLparameters.urlText.rawValue + urlString  + URLparameters.repositoriesParam.rawValue
    
    guard var url = URL(string: completeUrlString) else {
      print(ErrorMessages.errorFailUrl)
      return
    }
    
    let parameters: [String: String] = [PaginationParameters.page.rawValue: String(describing: page),
                                        PaginationParameters.perPage.rawValue: PaginationParameters.resultsPerPage.rawValue]
    
    url = url.appendingQueryParameters(parameters)
    let urlRequest = URLRequest(url:url)
    
    let configuration = URLSessionConfiguration.default
    let session = URLSession(configuration: configuration)
    
    let task = session.dataTask(with: urlRequest) {
      (data, response, error) in
      guard error == nil else {
        print(error!)
        return
      }
      
      guard let receivedData = data else {
        return
      }
      
      let jsonDecoder = JSONDecoder()
      
      do {
        let repository = try jsonDecoder.decode([RepositoryDataModel].self, from: receivedData)
        Storage.shared.repositoryComponents += repository
        
        if repository.count == 10 {
          completion(true)
        } else {
          completion(false)
        }
        
      } catch {
        print(error)
      }
      
    }
    task.resume()
  }
  
}

protocol URLQueryParameterStringConvertible {
  var queryParameters: String { get }
}

extension Dictionary : URLQueryParameterStringConvertible {
  var queryParameters: String {
    var parts: [String] = []
    for (key, value) in self {
      let part = String(format: "%@=%@",
                        String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                        String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
      parts.append(part as String)
    }
    return parts.joined(separator: "&")
  }
  
}

extension URL {
  func appendingQueryParameters(_ parametersDictionary : Dictionary<String, String>) -> URL {
    let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
    return URL(string: URLString)!
  }
  
}
