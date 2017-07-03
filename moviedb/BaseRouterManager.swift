//
//  BaseRouter.swift
//  moviedb
//
//  Created by Ines on 6/30/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import Alamofire

class BaseRouterManager: RouterManager {
  
  class func route(router: Router) throws -> URLRequest {
    return try buildRequest(path: router.path, method: router.method, parameters: router.params)
  }
  
  class func buildRequest(path: String, method: Alamofire.HTTPMethod, parameters: Dictionary<String, AnyObject>?) throws -> URLRequest {
    let url = URL(string: Constants.APIConstants.kBaseURL)!
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    urlRequest.httpMethod = method.rawValue
    return try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)
  }
}
