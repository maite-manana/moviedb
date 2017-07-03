//
//  ContentCell.swift
//  moviedb
//
//  Created by Maite Mañana on 6/26/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import UIKit

class ContentCell: UITableViewCell {
    
  @IBOutlet weak var poster: UIImageView!
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var additionalData: UILabel?
  @IBOutlet weak var backgroundCardView: UIView?
  
  func configure(movie: Movie) {
    self.selectionStyle = UITableViewCellSelectionStyle.none
    self.title.text = movie.title
    self.additionalData?.text = movie.overview
    ImageViewUtils.loadImage(imageURL: movie.posterPath!, imageView: self.poster!)
    setupBackground()
  }
  
  func setupBackground() {
    self.backgroundCardView?.backgroundColor = UIColor.white
    contentView.backgroundColor = UIColor(colorLiteralRed: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
    backgroundCardView?.layer.cornerRadius = 5.0
    backgroundCardView?.layer.masksToBounds = false
    backgroundCardView?.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
    backgroundCardView?.layer.shadowOpacity = 0.8
  }
}
