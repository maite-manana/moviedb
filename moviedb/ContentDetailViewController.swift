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
    
    var selectedContent = Movie()
    
    @IBOutlet weak var contentDescription: UILabel!
    
    @IBOutlet weak var contentTitle: UILabel!
    
    @IBOutlet weak var contentImage: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        contentTitle.text = selectedContent.title
        contentDescription.text = selectedContent.overview
        contentDescription.sizeToFit()
        let url = URL(string: Constants.APIConstants.kBaseImageURL + selectedContent.posterPath!)
        let data = try? Data(contentsOf: url!)
        contentImage.image = UIImage(data: data!)
        
        let addButton = UIBarButtonItem.init(barButtonSystemItem: .action, target: self, action: #selector(shareContent))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @IBAction func shareContent() {
        var url  = NSURL(string: "whatsapp://send?text=Hello%20Friends%2C%20Sharing%20some%20data%20here...%20!")
        
        //Text which will be shared on WhatsApp is: "Hello Friends, Sharing some data here... !"
        
        if UIApplication.shared.canOpenURL(url! as URL) {
            UIApplication.shared.openURL(url! as URL)
        }
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
