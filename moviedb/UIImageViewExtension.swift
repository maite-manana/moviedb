//
//  UIImageViewExtension.swift
//  moviedb
//
//  Created by Ines on 7/10/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import UIKit

extension UIImageView {
  public func imageFromServerURL(urlString: String) {
    
    URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { (data, response, error) -> Void in
      
      if error != nil {
        return
      }
      DispatchQueue.main.async(execute: { () -> Void in
        let image = UIImage(data: data!)
        self.image = image
      })
      
    }).resume()
  }
}
