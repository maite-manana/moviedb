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
        if (response.result.value != nil) {
          let responseMovie = response.result.value!
          completionHandler(responseMovie)
        } else {
          self.handleError(error: response.result.error as NSError?)
          completionHandler(nil)
        }
      })
  }
  
  func handleError(error: NSError?) {
    if error != nil {
      MessageHandler.showMessage(title: "Error", body: "Ha ocurrido un error", type: messageType.ERROR)
    }
  }
}
