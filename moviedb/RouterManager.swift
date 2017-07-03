//
//  RouterManager.swift
//  moviedb
//
//  Created by Ines on 6/30/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import Alamofire

protocol RouterManager {
  
  static func route(router: Router) throws -> URLRequest
  
}
