//
//  HomeView.swift
//  moviedb
//
//  Created by Ines on 6/28/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation

protocol HomeView {
    func startLoading()
    func finishLoading()
    func setContent(moviesList: [Movie])
    func setEmptyContent()
}
