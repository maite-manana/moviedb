//
//  ShareUtils.swift
//  moviedb
//
//  Created by Ines on 7/1/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation

struct ShareUtils {
  
  static func shareWhatsApp(videos: [Video]) -> URL {
    let videoUrl = videos.count > 0 ? Constants.APIConstants.kBaseYouTube + videos[0].key! : ""
    let urlString = "Sending WhatsApp message through app in Swift." + videoUrl
    let urlwithPercentEscapes = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    return URL(string: "whatsapp://send?text=\(urlwithPercentEscapes!)")!
  }
}
