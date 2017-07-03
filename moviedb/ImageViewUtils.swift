//
//  ImageViewUtils.swift
//  moviedb
//
//  Created by Ines on 6/30/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import UIKit

struct ImageViewUtils {
  
  static func loadImage(imageURL: String, imageView: UIImageView) {
    if let url = URL(string: Constants.APIConstants.kBaseImageURL + imageURL) {
      if let data = try? Data(contentsOf: url) {
        let image = UIImage(data: data)
        imageView.image = image
      }
    }
  }
}
