//
//  RandomChooserView.swift
//  moviedb
//
//  Created by Ines on 6/28/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation

protocol RandomChooserView {
    func startLoading()
    func finishLoading()
    func setGenres(genreList: [Genre])
    func setRandom(movieList: [Movie])
}
