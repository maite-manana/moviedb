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
        let url = URL(string: Constants.APIConstants.kBaseImageURL + selectedContent.posterPath!)
        let data = try? Data(contentsOf: url!)
        contentImage.image = UIImage(data: data!)
    }
    
    @IBAction func shareContent(_ sender: UIBarButtonItem) {
        var url  = NSURL(string: "whatsapp://send?text=Hello%20Friends%2C%20Sharing%20some%20data%20here...%20!")
        
        //Text which will be shared on WhatsApp is: "Hello Friends, Sharing some data here... !"
        
        if UIApplication.shared.canOpenURL(url! as URL) {
            UIApplication.shared.openURL(url! as URL)
        }
    }
}
