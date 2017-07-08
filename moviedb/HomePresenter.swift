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
  
  func getContent() {
    homeView?.startLoading()
    
    APIManager.sharedInstance.getNowPlayingMovies(completionHandler: { (baseResponse) in
      self.homeView?.finishLoading()
      
      var movies = [Movie]()
      let coversResponse = baseResponse?.results as! Array<NSDictionary>
      movies = coversResponse.map({ (responseDictionary) -> Movie in
        Mapper<Movie>().map(JSONObject: responseDictionary)!
      })
      
      self.homeView?.setContent(moviesList: movies)
    });
  }
  
  func shareAction(id: String) {
    getContentVideo(id: id)
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
  
  func addFav(id: Int, title: String, posterPath: String, overview: String){
    if checkIfFavorite(id: id) {
        context.delete(favElem[0] as NSManagedObject)
        do {
            try context.save()
            homeView?.showSuccessUnfavMessage()
        } catch {
            homeView?.showSuccessUnfavMessage()
        }
    } else {
        let fav = NSEntityDescription.insertNewObject(forEntityName: "Fav", into:self.context) as! Fav
        fav.id = Int32(id)
        fav.title = title
        fav.posterPath = posterPath
        fav.overview = overview
        
        do {
            try context.save()
            homeView?.showSuccessFavMessage()
        } catch {
            homeView?.showSuccessFavMessage()
        }
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
  
}
