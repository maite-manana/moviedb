//
//  MovieChooserViewController.swift
//  moviedb
//
//  Created by Ines on 6/28/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import UIKit
import Foundation

class MovieChooserViewController: UIViewController {
  
  fileprivate var movieChooserPresenter = MovieChooserPresenter()
  
  var selectedGenre = [String]()
  
  @IBOutlet weak var movieTableView: UITableView!
  @IBOutlet weak var loadingView: UILoadingView!
  
  var contentList: ArraySlice<Movie> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    movieChooserPresenter.attachView(self)
    loadingView.setupLoadingIndicator()
    setupContentTable()
    movieChooserPresenter.getMoviesByGenre(genreList: selectedGenre)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    movieTableView.tableFooterView = UIView(frame: CGRect.zero)
  }
}

extension MovieChooserViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.contentList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ContentCell
    cell.configure(movie: contentList[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
  {
    return 165.0
  }
  
  func setupContentTable() {
    movieTableView.dataSource = self
    movieTableView.delegate = self
    
    let nib = UINib(nibName: "ContentCell", bundle: nil)
    self.movieTableView.register(nib, forCellReuseIdentifier: "cell")
  }
}

extension MovieChooserViewController: UITableViewDelegate {
  
}

extension MovieChooserViewController: MovieChooserView {
  func startLoading() {
    loadingView.showLoadingIndicator()
  }
  
  func finishLoading() {
    loadingView.hideLoadingIndicator()
  }
  
  func setMovies(movieList: [Movie]) {
    contentList = movieList[0..<3]
    movieTableView.reloadData()
  }
}
