//
//  ApiManager.swift
//  moviedb
//
//  Created by Ines on 6/24/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class APIManager: NSObject {
    var kBaseAuthURL : String!

    static let sharedInstance = APIManager()

    private override init() {
        self.kBaseAuthURL = Constants.APIConstants.kBaseURL
    }
    
    func getMovies(completionHandler: @escaping (BaseResponse) -> Void)
    {
        let params: Parameters = [
            "api_key": Constants.APIConstants.kApiKey
        ]
    
//        Alamofire.request(
//           Constants.APIConstants.kBaseURL + "/discover/movie",
//            method: .get,
//            parameters: params
//            ).responseObject { (response: DataResponse<BaseResponse>) -> Void in
//                let responseMovie = response.result.value
//        }
        
        Alamofire.request(
            Constants.APIConstants.kBaseURL + "/discover/movie",
            method: .get,
            parameters: params
            ).responseObject(completionHandler: { (response: DataResponse<BaseResponse>) -> Void in
                let responseMovie = response.result.value!
                completionHandler(responseMovie)
            })
    }
}
