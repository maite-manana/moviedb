//
//  FavCell.swift
//  moviedb
//
//  Created by Maite Mañana on 7/3/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import UIKit

class FavCell: UITableViewCell {
  
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var poster: UIImageView!
  @IBOutlet weak var overview: UILabel!
  @IBOutlet weak var backgroundCardView: UIView!
  
  func configure(fav: Fav) {
    self.selectionStyle = UITableViewCellSelectionStyle.none
    self.title.text = fav.title
    if (self.title.text?.isEmpty)! {
        self.title.text = Constants.DefaultTexts.kDefaultTitle
    }
    
    self.overview.text = fav.overview
    if (self.overview.text?.isEmpty)! {
      self.overview.text = Constants.DefaultTexts.kDefaultOverview
    }

    let poster = fav.posterPath
    if poster != nil  && poster != "" {
      ImageViewUtils.loadImage(imageURL: poster!, imageView: self.poster!)
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
