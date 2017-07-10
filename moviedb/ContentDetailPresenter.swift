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
  var isFav: Bool!
  var favElem: [NSManagedObject] = []
  
  
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
    
  func checkIfFavorite(id: Int) -> Bool {
    let predicate = NSPredicate(format: "id == %@", id as NSNumber)
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Fav")
    fetchRequest.predicate = predicate
    
    do {
      favElem = try context.fetch(fetchRequest) as! [NSManagedObject]
        
    } catch {}
    isFav = !favElem.isEmpty
    return isFav
    
  }
  
  func markAsFavourite(movie: Movie) {
    if checkIfFavorite(id: movie.id!) {
        context.delete(favElem[0] as NSManagedObject)
        do {
            try context.save()
            contentDetailView?.showSuccessUnfavMessage()
        } catch {
            contentDetailView?.showSuccessUnfavMessage()
        }
    } else {
        let fav = NSEntityDescription.insertNewObject(forEntityName: "Fav", into:self.context) as! Fav
        fav.id = Int32(movie.id!)
        if let title = movie.title {
            fav.title = title
        } else if let name = movie.name {
            fav.title = name
        }
        fav.posterPath = movie.posterPath
        fav.overview = movie.overview
        
        do {
            try context.save()
            contentDetailView?.showSuccessFavMessage()
        } catch {
            contentDetailView?.showSuccessFavMessage()
        }
    }
  }
}
