//
//  HomeViewController.swift
//  moviedb
//
//  Created by Maite Mañana on 6/14/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import UIKit
import Foundation
import TabPageViewController
import DZNEmptyDataSet

class HomeViewController: UIViewController {
  
  @IBOutlet weak var moviesTableView: UITableView!
  @IBOutlet weak var loadingView: UILoadingView!
  
  fileprivate var homePresenter = HomePresenter()
  
  var contentList: ArraySlice<Movie> = []
  var selectedItem: Movie!
  let searchController = UISearchController(searchResultsController: nil)
  var favActionTitle = "Fav"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    homePresenter.attachView(self)
    loadingView.setupLoadingIndicator()
    setupContentTable()
    homePresenter.getContent()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    moviesTableView.tableFooterView = UIView(frame: CGRect.zero)
  }
}

extension HomeViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.contentList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ContentCell
    cell.configure(movie: contentList[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedItem = contentList[indexPath.row]
    self.performSegue(withIdentifier: "contentDetail", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let contentDetailViewController = segue.destination as! ContentDetailViewController
    contentDetailViewController.selectedContent = selectedItem
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
  {
    return 165.0
  }
  
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let id = self.contentList[indexPath.row].id!
    let added = self.homePresenter.checkIfFavorite(id: id)
    if added {
        self.favActionTitle = "Unfav"
    } else {
        self.favActionTitle = "Fav"
    }
    let favorite = UITableViewRowAction(style: .normal, title: favActionTitle) { action, index in
      let title = self.contentList[indexPath.row].title!
      let posterPath = self.contentList[indexPath.row].posterPath!
      let overview = self.contentList[indexPath.row].overview!
      self.homePresenter.addFav(id: id, title: title, posterPath: posterPath, overview: overview)
      tableView.setEditing(false, animated: true)

    }
    favorite.backgroundColor = Constants.Colors.kIndigo
    
    let share = UITableViewRowAction(style: .normal, title: "Share") { action, index in
      let id = String(self.contentList[indexPath.row].id!)
      self.homePresenter.shareAction(id: id)
    }
    share.backgroundColor = Constants.Colors.kBlueLight

    return [share, favorite]
  }
  
  func setupContentTable() {
    searchController.searchBar.delegate = self
    moviesTableView.dataSource = self
    moviesTableView.delegate = self
    moviesTableView.separatorStyle = .none
    moviesTableView.tableHeaderView = searchController.searchBar
    let nib = UINib(nibName: "ContentCell", bundle: nil)
    self.moviesTableView.register(nib, forCellReuseIdentifier: "cell")
  }
}

extension HomeViewController: UITableViewDelegate {}

extension HomeViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
  
  func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
    return UIImage(named: "nofilms")
  }
  
  func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
    let myString = Constants.Messages.kNoFilmsZeroState
    let myAttribute = [ NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15) ]
    
    return NSAttributedString(string: myString, attributes: myAttribute)
  }
  
  func setupEmptyDataSet() {
    moviesTableView.emptyDataSetSource = self
    moviesTableView.emptyDataSetDelegate = self
    moviesTableView.tableFooterView = UIView()
  }
}

extension HomeViewController : UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if let searchText = searchController.searchBar.text, !searchText.isEmpty {
      homePresenter.searchMovie(name: searchText)
    }
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    homePresenter.getContent()
  }
}

extension HomeViewController: HomeView {
  func startLoading() {
    loadingView.showLoadingIndicator()
  }
  
  func finishLoading() {
    loadingView.hideLoadingIndicator()
  }
  
  func setContent(moviesList: [Movie]) {
    setupEmptyDataSet()
    contentList = moviesList[0..<5]
    moviesTableView.reloadData()
  }
  
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
