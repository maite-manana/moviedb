//
//  TvRouter.swift
//  moviedb
//
//  Created by Ines on 7/10/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import Alamofire

enum TvRouter: Router {
  case GetTvNowPlaying()
  case SearchTv(tvName: String)
  
  var params: Dictionary<String, AnyObject>? {
    switch self {
    case .GetTvNowPlaying():
      return ["api_key" : Constants.APIConstants.kApiKey as AnyObject]
    case .SearchTv(let tvName):
      let parameters : Dictionary<String, AnyObject> = [
        "api_key" :  Constants.APIConstants.kApiKey as AnyObject,
        "query" : tvName as AnyObject]
      return parameters
    }
  }
  
  var path: String {
    switch self {
    case .GetTvNowPlaying():
      return "/tv/on_the_air"
    case .SearchTv(_):
      return "/search/tv"
    }
  }
  
  var method: Alamofire.HTTPMethod {
    return .get
  }
}
