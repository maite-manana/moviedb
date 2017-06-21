//
//  APIHandler.swift
//  moviedb
//
//  Created by Maite Mañana on 6/20/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import Alamofire

class MovieDbService {
    static var apiKey = "053876183f264d50ee96838f8b56ba91"
    
    func alamofireGetContent() -> Void {
        let params: Parameters = [
            "api_key": MovieDbService.apiKey
        ]

        Alamofire.request(
            "https://api.themoviedb.org/3/discover/movie",
            method: .get,
            parameters: params,
            encoding: JSONEncoding.default,
            headers: nil
            ).responseJSON(completionHandler: { [unowned self] response in
                print(response)
            })
    }
}
