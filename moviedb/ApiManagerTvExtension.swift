//
//  ApiManagerTvExtension.swift
//  moviedb
//
//  Created by Ines on 7/10/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import ObjectMapper

extension APIManager {
  typealias TvCompletionHandler = (BaseResponse?) -> Void
  
  func getNowPlayingTv(completionHandler: @escaping TvCompletionHandler)
  {
    requestForObjectResponse(manager: BaseRouterManager.self, router: TvRouter.GetTvNowPlaying(), completionHandler: completionHandler)
  }
  
  func searchTv(tvName: String, completionHandler: @escaping TvCompletionHandler)
  {
    requestForObjectResponse(manager: BaseRouterManager.self, router: TvRouter.SearchTv(tvName: tvName), completionHandler: completionHandler)
  }
}
