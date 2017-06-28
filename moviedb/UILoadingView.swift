//
//  LoadingView.swift
//  moviedb
//
//  Created by Ines on 6/27/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import UIKit

protocol LoaderProtocol {
    
    func hideLoadingIndicator()
    func showLoadingIndicator()
}

class UILoadingView : UIView, LoaderProtocol {
    
    var loadingIndicator : UIActivityIndicatorView?
    
    func setupLoadingIndicator(size: CGFloat? = CGFloat(50), height: CGFloat? = CGFloat(80), width: CGFloat? = CGFloat(80)) {
        loadingIndicator = UIActivityIndicatorView()
        loadingIndicator!.frame = CGRect(x: 0, y: 0, width: width!, height: height!)
        loadingIndicator?.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.addSubview(loadingIndicator!)
    }
    
    func showLoadingIndicator() {
        self.isHidden = false
        self.loadingIndicator!.startAnimating()
    }
    
    func hideLoadingIndicator() {
        self.isHidden = true
        self.loadingIndicator!.stopAnimating()
    }
}
