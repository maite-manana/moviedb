//
//  FavViewController.swift
//  moviedb
//
//  Created by Maite Mañana on 7/3/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class FavViewController: UIViewController {
    var favList: [Fav] = []
    fileprivate var favPresenter = FavPresenter()
    
    @IBOutlet weak var loadingView: UILoadingView!
    @IBOutlet weak var favTableView: UITableView!
    
    override func viewDidLoad() {
        favTableView.dataSource = self
        favTableView.delegate = self
        
        loadingView.setupLoadingIndicator()
        favPresenter.attachView(self)
        favPresenter.getContent()
        
        let nib = UINib(nibName: "FavCell", bundle: nil)
        self.favTableView.register(nib, forCellReuseIdentifier: "cell")
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
}

extension FavViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! FavCell
        cell.configure(fav: favList[indexPath.row])
        return cell
    }
}

extension FavViewController: UITableViewDelegate {}

extension FavViewController: FavView {

    func startLoading() {
        loadingView.showLoadingIndicator()
    }
    
    func finishLoading() {
        loadingView.hideLoadingIndicator()
    }
    
    func setContent(favsList: [Fav]) {
        favList = favsList
        favTableView.reloadData()
    }
    
    func setEmptyContent() {
    }
}


