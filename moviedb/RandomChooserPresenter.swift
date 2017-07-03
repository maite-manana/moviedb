//
//  RandomChooserPresenter.swift
//  moviedb
//
//  Created by Ines on 6/27/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import ObjectMapper

class RandomChooserPresenter {
    
    fileprivate var randomChooserView: RandomChooserView?
    
    func attachView(_ view:RandomChooserView) {
        randomChooserView = view
    }
    
    func detachView() {
        randomChooserView = nil
    }
    
    func getGenres() {
        randomChooserView?.startLoading()

        APIManager.sharedInstance.getGenreList(completionHandler: {(genreReport) in
            self.randomChooserView?.finishLoading()
            self.randomChooserView?.setGenres(genreList: (genreReport?.genres!)!)
        })
    }
}
