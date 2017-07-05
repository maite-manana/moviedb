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
  
  @IBOutlet weak var contentDescription: UILabel!
  
  @IBOutlet weak var contentTitle: UILabel!
  
  @IBOutlet weak var contentImage: UIImageView!
  
  @IBOutlet weak var favButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    contentDetailPresenter.attachView(self)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    contentTitle.text = selectedContent.title
    contentDescription.text = selectedContent.overview
    contentDescription.sizeToFit()
    let url = URL(string: Constants.APIConstants.kBaseImageURL + selectedContent.posterPath!)
    let data = try? Data(contentsOf: url!)
    contentImage.image = UIImage(data: data!)
    
    let shareButton = UIBarButtonItem.init(barButtonSystemItem: .action, target: self, action: #selector(shareContent))
    self.navigationItem.rightBarButtonItem = shareButton
  }
  
  @IBAction func markAsFavourite(_ sender: Any) {
    contentDetailPresenter.markAsFavourite(movie: selectedContent)
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
}
