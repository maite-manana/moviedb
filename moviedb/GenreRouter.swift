//
//  GenreRouter.swift
//  moviedb
//
//  Created by Ines on 7/1/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import Alamofire

enum GenreRouter: Router {
  case GetGenreList()
  
  var params: Dictionary<String, AnyObject>? {
    switch self {
    case .GetGenreList():
      return ["api_key" : Constants.APIConstants.kApiKey as AnyObject]
      }
  }
  
  var path: String {
    switch self {
    case .GetGenreList():
      return "/genre/movie/list"
    }
  }
  
  var method: Alamofire.HTTPMethod {
    return .get
  }

}
