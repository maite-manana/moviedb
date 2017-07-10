//
//  HomePresenter.swift
//  moviedb
//
//  Created by Maite Mañana on 6/20/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreData

class HomePresenter {
  fileprivate var homeView: HomeView?
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  var isFav: Bool!
  var favElem: [NSManagedObject] = []
  
  func attachView(_ view:HomeView) {
    homeView = view
  }
  
  func detachView() {
    homeView = nil
  }
  
  func getTvContent() {
    homeView?.startLoading()
    
    APIManager.sharedInstance.getNowPlayingTv(completionHandler: { (baseResponse) in
      self.homeView?.finishLoading()
      
        var firstMovies = [Movie]()
        if (baseResponse != nil) {
            let coversResponse = baseResponse?.results as! Array<NSDictionary>
            let movies = coversResponse.map({ (responseDictionary) -> Movie in
                Mapper<Movie>().map(JSONObject: responseDictionary)!
            })
            firstMovies = movies.count > 5 ? Array(movies.prefix(5)) : movies
        }

      
      self.homeView?.setContent(moviesList: firstMovies)
    });
  }
  
  func getContent() {
    homeView?.startLoading()
    
    APIManager.sharedInstance.getNowPlayingMovies(completionHandler: { (baseResponse) in
      self.homeView?.finishLoading()
      
      var firstMovies = [Movie]()
      if (baseResponse != nil) {
        let coversResponse = baseResponse?.results as! Array<NSDictionary>
        let movies = coversResponse.map({ (responseDictionary) -> Movie in
          Mapper<Movie>().map(JSONObject: responseDictionary)!
        })
        firstMovies = movies.count > 5 ? Array(movies.prefix(5)) : movies
      }
      self.homeView?.setContent(moviesList: firstMovies)
    });
  }
  
  func shareAction(id: String) {
    getContentVideo(id: id)
  }

  func addFav(id: Int, title: String, posterPath: String, overview: String){
    let response = FavHandler.addFav(id: id, title: title, posterPath: posterPath, overview: overview)
    switch response {
    case Constants.FavResults.kUnFavSuccess:
        homeView?.showSuccessUnfavMessage()
    case Constants.FavResults.kUnFavError:
        homeView?.showErrorUnfavMessage()
    case Constants.FavResults.kFavSuccess:
        homeView?.showSuccessFavMessage()
    case Constants.FavResults.kFavError:
        homeView?.showErrorFavMessage()
    default:
      break
    }
  }
  
  func getContentVideo(id: String) {
    APIManager.sharedInstance.getVideos(movieId: id, completionHandler: {
      (baseResponse) in
      var videos = [Video]()
      let coversResponse = baseResponse?.results as! Array<NSDictionary>
      videos = coversResponse.map({ (responseDictionary) -> Video in
        Mapper<Video>().map(JSONObject: responseDictionary)!
      })
      self.shareContent(videos: videos)
    });
  }
  
  func shareContent(videos: [Video]) {
    let url = ShareUtils.shareWhatsApp(videos: videos)
    if UIApplication.shared.canOpenURL(url as URL) {
      UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
  }
  
  func searchMovie(name: String) {
    homeView?.startLoading()
    
    APIManager.sharedInstance.searchMovie(movieName: name, completionHandler: { (baseResponse) in
      self.homeView?.finishLoading()
      
      var movies = [Movie]()
      if (baseResponse != nil) {
        let coversResponse = baseResponse?.results as! Array<NSDictionary>
        movies = coversResponse.map({ (responseDictionary) -> Movie in
          Mapper<Movie>().map(JSONObject: responseDictionary)!
        })
      }
      self.homeView?.setContent(moviesList: movies)
    });
  }
  
  func searchTv(name: String) {
    homeView?.startLoading()
    
    APIManager.sharedInstance.searchTv(tvName: name, completionHandler: { (baseResponse) in
      self.homeView?.finishLoading()
      
      var movies = [Movie]()
      let coversResponse = baseResponse?.results as! Array<NSDictionary>
      movies = coversResponse.map({ (responseDictionary) -> Movie in
        Mapper<Movie>().map(JSONObject: responseDictionary)!
      })
      
      self.homeView?.setContent(moviesList: movies)
    });
  }
}
