//
//  Video.swift
//  moviedb
//
//  Created by Ines on 6/27/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import ObjectMapper

class Video: Mappable {
    init() {}
    
    var key: String?
    var site: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        key <- map["key"]
        site <- map["site"]
    }
}
