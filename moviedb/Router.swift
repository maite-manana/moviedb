//
//  Router.swift
//  moviedb
//
//  Created by Ines on 6/28/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import Alamofire

protocol Router {
    
    var params: Dictionary<String, AnyObject>? { get }
    
    var path: String { get }
}
