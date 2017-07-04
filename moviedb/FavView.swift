//
//  FavView.swift
//  moviedb
//
//  Created by Maite Mañana on 7/3/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import CoreData

protocol FavView {
    func startLoading()
    func finishLoading()
    func setContent(favsList: [Fav])
}
