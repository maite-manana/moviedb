//
//  ContentDetailViewController.swift
//  moviedb
//
//  Created by Ines on 6/24/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import UIKit

class ContentDetailViewController : UIViewController {
  
  fileprivate var contentDetailPresenter = ContentDetailPresenter()
  
  var selectedContent: Movie!
    
  var fav = false
  
  @IBOutlet weak var contentDescription: UILabel!
  
  @IBOutlet weak var contentTitle: UILabel!
  
  @IBOutlet weak var contentImage: UIImageView!
  
  @IBOutlet weak var favButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    contentDetailPresenter.attachView(self)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    if let title = selectedContent.title {
      contentTitle.text = title
    } else if let name = selectedContent.name {
      contentTitle.text = name
    }
    contentDescription.text = selectedContent.overview
    contentDescription.sizeToFit()
    let url = URL(string: Constants.APIConstants.kBaseImageURL + selectedContent.posterPath!)
    let data = try? Data(contentsOf: url!)
    contentImage.image = UIImage(data: data!)
    
    setFavButton(favImage: #imageLiteral(resourceName: "heartfill"), notFavImage: #imageLiteral(resourceName: "heart"))
    
    let shareButton = UIBarButtonItem.init(barButtonSystemItem: .action, target: self, action: #selector(shareContent))
    self.navigationItem.rightBarButtonItem = shareButton
  }
  
  @IBAction func markAsFavourite(_ sender: Any) {
    setFavButton(favImage: #imageLiteral(resourceName: "heart"), notFavImage: #imageLiteral(resourceName: "heartfill"))
    contentDetailPresenter.markAsFavourite(movie: selectedContent)
  }
    
    func setFavButton(favImage: UIImage, notFavImage: UIImage) {
    fav = FavHandler.checkIfFavorite(id: selectedContent.id!)
    if fav {
        favButton.setImage(favImage, for: .normal)
    } else {
        favButton.setImage(notFavImage, for: .normal)
    }
  }
  
  func shareContent() {
    contentDetailPresenter.shareContent(id: String(selectedContent.id!))
  }
  
  func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
    let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.text = text
    label.sizeToFit()
    
    return label.frame.height
  }
}

extension ContentDetailViewController : ContentDetailView {
  
  func showSuccessFavMessage() {
    MessageHandler.showMessage(title: "❤️", body: Constants.Messages.kFavSuccessMessage, type: messageType.SUCCESS)
  }
  
  func showErrorFavMessage() {
    MessageHandler.showMessage(title: Constants.Messages.kGenericErrorMessage, body: Constants.Messages.kFavErrorMessage, type: messageType.ERROR)
  }
    
  func showSuccessUnfavMessage() {
    MessageHandler.showMessage(title: "🖤", body: Constants.Messages.kUnfavSuccessMessage, type: messageType.SUCCESS)
  }
    
  func showErrorUnfavMessage() {
    MessageHandler.showMessage(title: Constants.Messages.kUnfavErrorMessage, body: Constants.Messages.kFavErrorMessage, type: messageType.ERROR)
  }
}
