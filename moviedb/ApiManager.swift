//
//  ApiManager.swift
//  moviedb
//
//  Created by Ines on 6/24/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class APIManager: NSObject {
  var kBaseAuthURL : String!
  
  static let sharedInstance = APIManager()
  
  func requestForObjectResponse<T: Mappable>(manager: RouterManager.Type, router: Router, completionHandler: @escaping (T?) -> Void)  {
    Alamofire.request(try! manager.route(router: router))
      .responseObject(completionHandler: { (response: DataResponse<T>) -> Void in
        let responseMovie = response.result.value!
        completionHandler(responseMovie)
      })
  }
  
  func handleError(error: NSError?) -> Bool {
    if error != nil {
      MessageHandler.showMessage(title: "Error", body: "Ha ocurrido un error", type: messageType.ERROR)
      return false
    }
    
    return true
  }
}
