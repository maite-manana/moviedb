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
    let fav = NSEntityDescription.insertNewObject(forEntityName: "Fav", into:self.context) as! Fav
    fav.title = movie.title
    fav.posterPath = movie.posterPath
    
    do {
      try context.save()
      contentDetailView?.showSuccessFavMessage()
    } catch {
      contentDetailView?.showSuccessFavMessage()
    }
  }
}
