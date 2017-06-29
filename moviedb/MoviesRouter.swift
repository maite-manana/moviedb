//
//  MoviesRouter.swift
//  moviedb
//
//  Created by Ines on 6/28/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

enum MoviesRouter: Router {
    case GetMoviesNowPlaying()
    
    var params: Dictionary<String, AnyObject>? {
        switch self {
        case .GetMoviesNowPlaying():
            return ["api_key" : Constants.APIConstants.kApiKey as AnyObject]
        }
    }

    var path: String {
        switch self {
        case .GetMoviesNowPlaying():
            return "/movie/now_playing"
        }
    }
}
