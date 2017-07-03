//
//  ApiManagerGenreExtension.swift
//  moviedb
//
//  Created by Ines on 7/1/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Alamofire
import ObjectMapper

extension APIManager {
  typealias GenreCompletionHandler = (GenreReport?) -> Void
  
  func getGenreList(completionHandler: @escaping GenreCompletionHandler)
  {
    requestForObjectResponse(manager: BaseRouterManager.self, router: GenreRouter.GetGenreList(), completionHandler: completionHandler)
  }
}
