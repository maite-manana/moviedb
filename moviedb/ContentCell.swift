//
//  ContentCell.swift
//  moviedb
//
//  Created by Maite Mañana on 6/26/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class ContentCell: UITableViewCell {
    
  @IBOutlet weak var poster: UIImageView!
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var additionalData: UILabel!
  @IBOutlet weak var backgroundCardView: UIView!
  
  func configure(movie: Movie) {
    self.selectionStyle = UITableViewCellSelectionStyle.none
    self.title.text = movie.title
    if let title = movie.title {
        self.title.text = title
    } else if let name = movie.name {
        self.title.text = name
    }
    if (self.title.text?.isEmpty)! {
        self.title.text = Constants.DefaultTexts.kDefaultTitle
    }
    
    self.additionalData.text = movie.overview
    if (self.additionalData.text?.isEmpty)! {
        self.additionalData.text = Constants.DefaultTexts.kDefaultOverview
    }
    
    let poster = movie.posterPath
    if poster != nil {
      self.poster.imageFromServerURL(urlString: Constants.APIConstants.kBaseImageURL + poster!)
    } else {
        self.poster.image = UIImage(named: "defaultPoster")
    }
    setupBackground()
  }
  
  func setupBackground() {
    self.backgroundCardView?.backgroundColor = UIColor.white
    contentView.backgroundColor = UIColor(colorLiteralRed: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
    backgroundCardView?.layer.cornerRadius = 5.0
    backgroundCardView?.layer.masksToBounds = false
  }
}

extension UIImageView {
  public func imageFromServerURL(urlString: String) {
        
  URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
    if error != nil {
      return
    }
    DispatchQueue.main.async(execute: { () -> Void in
      let image = UIImage(data: data!)
      self.image = image
    })
            
  }).resume()
}}

