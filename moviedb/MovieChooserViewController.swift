//
//  MovieChooserViewController.swift
//  moviedb
//
//  Created by Ines on 6/28/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import UIKit
import Foundation
import DZNEmptyDataSet

class MovieChooserViewController: UIViewController {
  
  fileprivate var movieChooserPresenter = MovieChooserPresenter()
  
  var selectedGenre = [String]()
  var movieIndex = 0
  
  @IBOutlet weak var movieTableView: UITableView!
  @IBOutlet weak var loadingView: UILoadingView!
  
  var contentList: [Movie] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    movieChooserPresenter.attachView(self)
    loadingView.setupLoadingIndicator()
    setupContentTable()
    movieChooserPresenter.getMoviesByGenre(genreList: selectedGenre)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    movieTableView.tableFooterView = UIView(frame: CGRect.zero)
    
    let reloadButton = UIBarButtonItem.init(image: UIImage(named: "reload"), style: .plain, target: self, action: #selector(reloadContent))
    self.navigationItem.rightBarButtonItem = reloadButton

  }
  
  func reloadContent() {
    movieChooserPresenter.getMoviesByGenre(genreList: selectedGenre)
  }
}

extension MovieChooserViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.contentList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ContentCell
    cell.configure(movie: contentList[indexPath.row])
    self.movieIndex += 1
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
  {
    return 165.0
  }
  
  func setupContentTable() {
    movieTableView.dataSource = self
    movieTableView.delegate = self
    movieTableView.separatorStyle = .none
    
    let nib = UINib(nibName: "ContentCell", bundle: nil)
    self.movieTableView.register(nib, forCellReuseIdentifier: "cell")
  }
}

extension MovieChooserViewController: MovieChooserView {
  func startLoading() {
    loadingView.showLoadingIndicator()
  }
  
  func finishLoading() {
    loadingView.hideLoadingIndicator()
  }
  
  func setMovies(movieList: [Movie], movieIndex: Int) {
    setupEmptyDataSet()
    contentList = movieList
    self.movieIndex = movieIndex
    movieTableView.reloadData()
  }
}

extension MovieChooserViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "nofilms")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let myString = Constants.Messages.kNoFilmsTryAgainZeroState
        let myAttribute = [ NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15) ]
        
        return NSAttributedString(string: myString, attributes: myAttribute)
    }
    
    func setupEmptyDataSet() {
        movieTableView.emptyDataSetSource = self
        movieTableView.emptyDataSetDelegate = self
        movieTableView.tableFooterView = UIView()
    }
}
