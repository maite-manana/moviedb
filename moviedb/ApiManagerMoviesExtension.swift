//
//  ApiManagerMoviesExtension.swift
//  moviedb
//
//  Created by Ines on 6/30/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Alamofire
import ObjectMapper

extension APIManager {
  typealias MoviesCompletionHandler = (BaseResponse?) -> Void
  
  func getNowPlayingMovies(completionHandler: @escaping MoviesCompletionHandler)
  {
    requestForObjectResponse(manager: BaseRouterManager.self, router: MoviesRouter.GetMoviesNowPlaying(), completionHandler: completionHandler)
  }
  
  func getVideos(movieId: String, completionHandler: @escaping MoviesCompletionHandler)
  {
    requestForObjectResponse(manager: BaseRouterManager.self, router: MoviesRouter.GatVideos(movieId: movieId), completionHandler: completionHandler)
  }
  
  func searchMovie(movieName: String, completionHandler: @escaping MoviesCompletionHandler)
  {
    requestForObjectResponse(manager: BaseRouterManager.self, router: MoviesRouter.SearchMovie(movieName: movieName), completionHandler: completionHandler)
  }
  
  func getSeries(completionHandler: @escaping MoviesCompletionHandler)
  {
    requestForObjectResponse(manager: BaseRouterManager.self, router: MoviesRouter.GetSeries(), completionHandler: completionHandler)
  }
  
  func getMoviesWithGenre(genresList: [String], completionHandler: @escaping MoviesCompletionHandler)
  {
    requestForObjectResponse(manager: BaseRouterManager.self, router: MoviesRouter.GetMoviesWithGenre(genresList: genresList), completionHandler: completionHandler)
  }
}
