//
//  ContentDetailPresenter.swift
//  moviedb
//
//  Created by Ines on 6/27/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import ObjectMapper

class ContentDetailPresenter {
    fileprivate var contentDetailView: ContentDetailView?
    
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
        //Hay que obtener el array y agregar una nueva peli, asi agrega solo una
        
        var movies = [Movie]()
        movies.append(movie)
        let defaults = UserDefaults.standard
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: movies as AnyObject)
        defaults.set(encodedData, forKey: "FavMovies")
        defaults.synchronize()
        contentDetailView?.showSuccessFavMessage()
    }
    
    func retrive() -> [Movie] {
        //esta funcion va en la vista de fav, la hice aca para probar que funcionara :)
        let defaults = UserDefaults.standard
        let decoded = defaults.object(forKey: "FavMovies")
        if decoded != nil {
            return NSKeyedUnarchiver.unarchiveObject(with: decoded as! Data) as! [Movie]
        }
        return [Movie]()
    }
}
