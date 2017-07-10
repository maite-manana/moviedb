//
//  ContentDetailPresenter.swift
//  moviedb
//
//  Created by Ines on 6/27/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreData

class ContentDetailPresenter {
  fileprivate var contentDetailView: ContentDetailView?
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  func attachView(_ view: ContentDetailView) {
    contentDetailView = view
  }
  
  func detachView() {
    contentDetailView = nil
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
  
  func shareContent(id: String) {
    getContentVideo(id: id)
  }
  
  func shareContent(videos: [Video]) {
    let url = ShareUtils.shareWhatsApp(videos: videos)
    
    if UIApplication.shared.canOpenURL(url as URL) {
      UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
  }
  
  func markAsFavourite(movie: Movie) {
    var title = ""
    if let movieTitle = movie.title {
        title = movieTitle
    } else if let tvTitle = movie.name {
        title = tvTitle
    }
    let response = FavHandler.addFav(id: movie.id!, title: title, posterPath: movie.posterPath!, overview: movie.overview!)
    switch response {
    case Constants.FavResults.kUnFavSuccess:
        contentDetailView?.showSuccessUnfavMessage()
    case Constants.FavResults.kUnFavError:
        contentDetailView?.showErrorUnfavMessage()
    case Constants.FavResults.kFavSuccess:
        contentDetailView?.showSuccessFavMessage()
    case Constants.FavResults.kFavError:
        contentDetailView?.showErrorFavMessage()
    default:
        break
    }
  }
}
