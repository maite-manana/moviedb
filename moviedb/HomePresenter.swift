//
//  HomePresenter.swift
//  moviedb
//
//  Created by Maite Mañana on 6/20/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import ObjectMapper

class HomePresenter {
    fileprivate var homeView: HomeView?
    
    func attachView(_ view:HomeView) {
        homeView = view
    }
    
    func detachView() {
        homeView = nil
    }

    func getContent() {
        homeView?.startLoading()
        
        APIManager.sharedInstance.getMovies(completionHandler: { (baseResponse) in
            self.homeView?.finishLoading()
            
            var movies = [Movie]()
            let coversResponse = baseResponse.results as! Array<NSDictionary>
            movies = coversResponse.map({ (responseDictionary) -> Movie in
                Mapper<Movie>().map(JSONObject: responseDictionary)!
            })
            
            self.homeView?.setContent(moviesList: movies)
        });
    }
}
