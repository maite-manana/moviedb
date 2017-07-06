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
  fileprivate var currentPage = 1
  fileprivate var listSize = 2
  fileprivate var inf = 0
  fileprivate var sup = 2
  fileprivate var currentGenreList = [String]()
  
    func attachView(_ view:MovieChooserView) {
        movieChooserView = view
    }
    
    func detachView() {
        movieChooserView = nil
    }
    
    func getMoviesByGenre(genreList: [String]) {
      currentGenreList = genreList
        movieChooserView?.startLoading()
        
      if sup >= listSize || sup > 20 {
        currentPage += 1
        inf = 0
        sup = 2
      }
        
      APIManager.sharedInstance.getMoviesWithGenre(genresList: genreList, pageNumber: currentPage, completionHandler: { (baseResponse) in
            self.movieChooserView?.finishLoading()
            
            var movies = [Movie]()
            let coversResponse = baseResponse?.results as! Array<NSDictionary>
            movies = coversResponse.map({ (responseDictionary) -> Movie in
                Mapper<Movie>().map(JSONObject: responseDictionary)!
            })
            self.listSize = movies.count
        
            if self.listSize < 3 {
                self.movieChooserView?.setMovies(movieList: [], movieIndex: self.inf)
                return
            }
        
            let moviesSliced = movies[self.inf...self.sup]
            self.movieChooserView?.setMovies(movieList: moviesSliced, movieIndex: self.inf)
            self.inf += 3
            self.sup += 3
        });
    }
}
