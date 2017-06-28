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

class HomeViewController: UIViewController {
    
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var loadingView: UILoadingView!
    
    fileprivate var homePresenter = HomePresenter()
    
    var contentList: ArraySlice<Movie> = []
    var selectedItem = Movie()
    var searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.setupLoadingIndicator()
        
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
    
        homePresenter.attachView(self)
        homePresenter.getContent()

        let nib = UINib(nibName: "ContentCell", bundle: nil)
        self.moviesTableView.register(nib, forCellReuseIdentifier: "cell")
        
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
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.title.text = contentList[indexPath.row].title
        cell.additionalData.text = contentList[indexPath.row].overview
        let url = URL(string: Constants.APIConstants.kBaseImageURL + contentList[indexPath.row].posterPath!)
        let data = try? Data(contentsOf: url!)
        cell.poster.image = UIImage(data: data!)
        
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
}

extension HomeViewController: UITableViewDelegate {}

extension HomeViewController: HomeView {
    func startLoading() {
        loadingView.showLoadingIndicator()
    }
    
    func finishLoading() {
        loadingView.hideLoadingIndicator()
    }
    
    func setContent(moviesList: [Movie]) {
        contentList = moviesList[0..<5]
        moviesTableView.reloadData()
    }
    
    func setEmptyContent() {
    }
}
