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
        
        Alamofire.request(
            Constants.APIConstants.kBaseURL + "/movie/now_playing",
            method: .get,
            parameters: params
            ).responseObject(completionHandler: { (response: DataResponse<BaseResponse>) -> Void in
                let responseMovie = response.result.value!
                completionHandler(responseMovie)
            })
    }
    
    func getSeries(completionHandler: @escaping (BaseResponse) -> Void)
    {
        let params: Parameters = [
            "api_key": Constants.APIConstants.kApiKey
        ]
        
        Alamofire.request(
            Constants.APIConstants.kBaseURL + "/discover/tv",
            method: .get,
            parameters: params
            ).responseObject(completionHandler: { (response: DataResponse<BaseResponse>) -> Void in
                let responseMovie = response.result.value!
                completionHandler(responseMovie)
            })
    }
    
    func getVideo(id: String, completionHandler: @escaping (BaseResponse) -> Void) {
        let params: Parameters = [
            "api_key": Constants.APIConstants.kApiKey,
        ]
        
        Alamofire.request(
            Constants.APIConstants.kBaseURL + "/movie/\(id)/videos",
        method: .get,
        parameters: params
            ).responseObject(completionHandler: { (response: DataResponse<BaseResponse>) -> Void in
                let responseVideo = response.result.value!
                completionHandler(responseVideo)
            })
    }
    
    func getGenre(completionHandler: @escaping (GenreReport) -> Void)
    {
        let params: Parameters = [
            "api_key": Constants.APIConstants.kApiKey
        ]
        
        Alamofire.request(
            Constants.APIConstants.kBaseURL + "/genre/movie/list",
            method: .get,
            parameters: params
            ).responseObject(completionHandler: { (response: DataResponse<GenreReport>) -> Void in
                let responseGenre = response.result.value!
                completionHandler(responseGenre)
            })
        
    }
    
    func getMoviesWithGenre(genresList: [String], completionHandler: @escaping (BaseResponse) -> Void) {
        let params: Parameters = [
            "api_key": Constants.APIConstants.kApiKey,
            "with_genres": genresList.joined(separator: ",")
        ]
        
        Alamofire.request(
            Constants.APIConstants.kBaseURL + "/discover/movie",
            method: .get,
            parameters: params
            ).responseObject(completionHandler: { (response: DataResponse<BaseResponse>) -> Void in
                let responseMovie = response.result.value!
                completionHandler(responseMovie)
            })
    }
    
    func findMovieByName(movieName: String, completionHandler: @escaping (BaseResponse) -> Void) {
        let params: Parameters = [
            "api_key": Constants.APIConstants.kApiKey,
            "query": movieName
        ]
        
        Alamofire.request(
            Constants.APIConstants.kBaseURL + "/search/movie",
            method: .get,
            parameters: params
            ).responseObject(completionHandler: { (response: DataResponse<BaseResponse>) -> Void in
                let responseMovie = response.result.value!
                completionHandler(responseMovie)
        })
    }
    
    
    func handleError(error: NSError?) -> Bool {
        if error != nil {
            MessageHandler.showMessage(title: "Error", body: "Ha ocurrido un error", type: messageType.ERROR)
            return false
        }

        return true
    }
}
