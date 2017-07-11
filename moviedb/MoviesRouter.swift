//
//  MoviesRouter.swift
//  moviedb
//
//  Created by Ines on 6/28/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import Alamofire

enum MoviesRouter: Router {
  case GetMoviesNowPlaying()
  case GatVideos(movieId: String)
  case SearchMovie(movieName: String)
  case GetMoviesWithGenre(genresList: [String], page: Int)
  
  var params: Dictionary<String, AnyObject>? {
    switch self {
    case .GetMoviesNowPlaying(), .GatVideos(_):
      return ["api_key" : Constants.APIConstants.kApiKey as AnyObject]
      
    case .SearchMovie(let movieName):
      let parameters : Dictionary<String, AnyObject> = [
        "api_key" :  Constants.APIConstants.kApiKey as AnyObject,
        "query" : movieName as AnyObject]
      return parameters
    case .GetMoviesWithGenre(let genresList, let page):
      let parameters : Dictionary<String, AnyObject> = [
        "api_key" :  Constants.APIConstants.kApiKey as AnyObject,
        "with_genres" : genresList.joined(separator: ",") as AnyObject,
        "page": page as AnyObject]
      return parameters
    }
  }
  
  var path: String {
    switch self {
    case .GetMoviesNowPlaying():
      return "/movie/now_playing"
    case .GatVideos(let id):
      return "/movie/\(id)/videos"
    case .SearchMovie(_):
      return "/search/movie"
    case .GetMoviesWithGenre(_):
      return "/discover/movie"
    }
  }
  
  var method: Alamofire.HTTPMethod {
    return .get
  }
}
