//
//  GenreReport.swift
//  moviedb
//
//  Created by Ines on 6/27/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import ObjectMapper

class GenreReport: Mappable {
    
    init() {}
    
    var genres: [Genre]?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        genres <- map["genres"]
    }
}
