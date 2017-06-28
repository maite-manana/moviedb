//
//  Movie.swift
//  moviedb
//
//  Created by Ines on 6/24/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import ObjectMapper
import Foundation

class Movie: NSObject, Mappable, NSCoding {
    
    required convenience init(coder decoder: NSCoder) {
        self.init()
        
        let id = decoder.decodeObject(forKey: "id") as? Int
        let voteAverage = decoder.decodeObject(forKey: "voteAverage") as? Int
        let title = decoder.decodeObject(forKey: "title") as? String
        let posterPath = decoder.decodeObject(forKey: "posterPath") as? String
        let overview = decoder.decodeObject(forKey: "overview") as? String
        
        self.id = id
        self.voteAverage = voteAverage
        self.title = title
        self.posterPath = posterPath
        self.overview = overview
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(voteAverage, forKey: "voteAverage")
        coder.encode(title, forKey: "title")
        coder.encode(posterPath, forKey: "posterPath")
        coder.encode(overview, forKey: "overview")
    }
    
    override init() {}

    var id: Int?
    var voteAverage: Int?
    var title: String?
    var posterPath: String?
    var overview: String?

    required init?(map: Map) { }

    func mapping(map: Map) {
        id <- map["id"]
        voteAverage <- map["vote_average"]
        title <- map["title"]
        posterPath <- map["poster_path"]
        overview <- map["overview"]
    }
}
