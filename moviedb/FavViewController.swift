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
import DZNEmptyDataSet

class FavViewController: UIViewController {
  var favList: [Fav] = []
  fileprivate var favPresenter = FavPresenter()
  
  @IBOutlet weak var loadingView: UILoadingView!
  @IBOutlet weak var favTableView: UITableView!
  
  override func viewDidLoad() {
    setupFavTable()
    loadingView.setupLoadingIndicator()
    favPresenter.attachView(self)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    favPresenter.getContent()
  }
}

extension FavViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.favList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! FavCell
    cell.configure(fav: favList[indexPath.row])
    return cell
  }
  
  func setupFavTable() {
    favTableView.dataSource = self
    favTableView.delegate = self
    favTableView.separatorStyle = .none
    favTableView.backgroundColor = UIColor(colorLiteralRed: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
    let nib = UINib(nibName: "FavCell", bundle: nil)
    self.favTableView.register(nib, forCellReuseIdentifier: "cell")
  }
    
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 165.0
  }
}

extension FavViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
  
  func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
    return UIImage(named: "nofavs")
  }
  
  func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
    let myString = Constants.Messages.kNoFavsZeroState
    let myAttribute = [ NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15) ]
    
    return NSAttributedString(string: myString, attributes: myAttribute)
  }
  
  func setupEmptyDataSet() {
    favTableView.emptyDataSetSource = self
    favTableView.emptyDataSetDelegate = self
    favTableView.tableFooterView = UIView()
  }
}

extension FavViewController: FavView {
  
  func startLoading() {
    loadingView.showLoadingIndicator()
  }
  
  func finishLoading() {
    loadingView.hideLoadingIndicator()
  }
  
  func setContent(favsList: [Fav]) {
    setupEmptyDataSet()
    favList = favsList
    favTableView.reloadData()
  }
}


