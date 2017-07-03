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

    func configure(fav: Fav) {
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.title.text = fav.title
        ImageViewUtils.loadImage(imageURL: fav.posterPath!, imageView: self.poster!)
    }
    
}
