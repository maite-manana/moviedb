//
//  MovieChooserPresenter.swift
//  moviedb
//
//  Created by Ines on 6/28/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieChooserPresenter {
    
    fileprivate var movieChooserView: MovieChooserView?
    
    func attachView(_ view:MovieChooserView) {
        movieChooserView = view
    }
    
    func detachView() {
        movieChooserView = nil
    }
    
    func getMoviesByGender(genreList: [String]) {
        movieChooserView?.startLoading()
        
        APIManager.sharedInstance.getMoviesWithGender(genresList: genreList, completionHandler: { (baseResponse) in
            self.movieChooserView?.finishLoading()
            
            var movies = [Movie]()
            let coversResponse = baseResponse.results as! Array<NSDictionary>
            movies = coversResponse.map({ (responseDictionary) -> Movie in
                Mapper<Movie>().map(JSONObject: responseDictionary)!
            })
            self.movieChooserView?.setMovies(movieList: movies)
        });
    }

}
