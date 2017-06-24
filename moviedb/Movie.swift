//
//  Movie.swift
//  moviedb
//
//  Created by Ines on 6/24/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import ObjectMapper

class Movie: Mappable {
    
    init() {}

    var id: Int?
    var voteAverage: Int?
    var title: String?
    var posterPath: String?
    var overview: String?

    required init?(map: Map) { }

    func mapping(map: Map) {
        id <- map["id"]
        voteAverage   <- map["vote_average"]
        title <- map["title"]
        posterPath <- map["poster_path"]
        overview <- map["overview"]
    }
}
