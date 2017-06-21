//
//  HomePresenter.swift
//  moviedb
//
//  Created by Maite Mañana on 6/20/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation

protocol HomeView {
    func startLoading()
    func finishLoading()
    func setContent()
    func setEmptyContent()
}

class HomePresenter {
    fileprivate var homeView: HomeView?
    
    func attachView(_ view:HomeView) {
        homeView = view
    }
    
    func detachView() {
        homeView = nil
    }

    func getContent() {
        homeView?.startLoading()
        
    }
}
