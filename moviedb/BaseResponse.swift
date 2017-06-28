//
//  BaseResponse.swift
//  moviedb
//
//  Created by Ines on 6/24/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import ObjectMapper

class BaseResponse: Mappable {
    
    var page: Int?
    var totalResults: Int?
    var totalPages: Int?
    var results: AnyObject?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        page <- map["page"]
        totalResults   <- map["total_results"]
        totalPages <- map["total_pages"]
        results <- map["results"]
    }
}
