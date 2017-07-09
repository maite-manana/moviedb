//
//  MovieChooserView.swift
//  moviedb
//
//  Created by Ines on 6/28/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation

protocol MovieChooserView {
    func startLoading()
    func finishLoading()
    func setMovies(movieList: [Movie], movieIndex: Int)
}
