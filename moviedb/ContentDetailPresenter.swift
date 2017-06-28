//
//  ContentDetailPresenter.swift
//  moviedb
//
//  Created by Ines on 6/27/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import ObjectMapper

protocol ContentDetailView {
    func showSuccessFavMessage()
}

class ContentDetailPresenter {
    fileprivate var contentDetailView: ContentDetailView?
    
    func attachView(_ view: ContentDetailView) {
        contentDetailView = view
    }
    
    func detachView() {
        contentDetailView = nil
    }
    
    func getContentVideo(id: String) {
        APIManager.sharedInstance.getVideo(id: id, completionHandler: {
            (baseResponse) in
            var videos = [Video]()
            let coversResponse = baseResponse.results as! Array<NSDictionary>
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
        let videoUrl = videos.count > 0 ? Constants.APIConstants.kBaseYouTube + videos[0].key! : ""
        let urlString = "Sending WhatsApp message through app in Swift." + videoUrl
        let urlwithPercentEscapes = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url  = NSURL(string: "whatsapp://send?text=\(urlwithPercentEscapes!)")
        
        if UIApplication.shared.canOpenURL(url! as URL) {
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
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
