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
import Alamofire

class HomeViewController: UIViewController {

    
    @IBOutlet weak var moviesTableView: UITableView!
    fileprivate var homePresenter = HomePresenter()
    var contentList: ArraySlice<Movie> = []
    var selectedItem = Movie()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
    
        homePresenter.attachView(self)
        homePresenter.getContent()
        
        
//        let tabPageViewController = TabPageViewController.create()
//        let vc1 = UIViewController()
//        let vc2 = UIViewController()
//        
//        vc1.view.backgroundColor = UIColor.red
//        vc2.view.backgroundColor = UIColor.blue
//        
//        tabPageViewController.tabItems = [(vc1, "Peliculas 🎥"), (vc2, "Series 🍿")]
//
//        let nc = UINavigationController()
//        nc.viewControllers = [tabPageViewController]
//        var option = TabPageOption()
//        option.currentColor = UIColor.black
//        option.tabMargin = 30.0
//        tabPageViewController.option = option
//        
//        navigationController?.pushViewController(tabPageViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        moviesTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        cell?.textLabel?.text = contentList[indexPath.row].title
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = contentList[indexPath.row]
        self.performSegue(withIdentifier: "contentDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let contentDetailViewController = segue.destination as! ContentDetailViewController
        contentDetailViewController.selectedContent = selectedItem
    }
}

extension HomeViewController: UITableViewDelegate {}

extension HomeViewController: HomeView {
    func startLoading() {
    }
    func finishLoading() {
    }
    
    func setContent(moviesList: [Movie]) {
        contentList = moviesList[0..<5]
        moviesTableView.reloadData()
    }
    
    func setEmptyContent() {
    }
}
