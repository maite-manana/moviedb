//
//  Genre.swift
//  moviedb
//
//  Created by Ines on 6/27/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import ObjectMapper

class Genre: Mappable {
    
    init() {}
    
    var id: Int?
    var name: String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
