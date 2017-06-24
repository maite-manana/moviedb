//
//  HomePresenter.swift
//  moviedb
//
//  Created by Maite Mañana on 6/20/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import ObjectMapper

protocol HomeView {
    func startLoading()
    func finishLoading()
    func setContent(moviesList: [Movie])
    func setEmptyContent()
}

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
            self.homeView?.setContent(moviesList: baseResponse.results!)
//            var movies = [Movie]()
//            let coversResponse = baseResponse.data as! Array<NSDictionary>
//            movies = coversResponse.map({ (movieDictionary) -> Movie in
//                Mapper<Movie>().map(movieDictionary)!
//            })
//            self.homeView?.setContent()
        });
    }
}
