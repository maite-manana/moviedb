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
    
    var contentList: ArraySlice<Movie> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTableView.dataSource = self
        movieTableView.delegate = self
        
        movieChooserPresenter.attachView(self)
        movieChooserPresenter.getMoviesByGenre(genreList: selectedGenre)

        
        let nib = UINib(nibName: "ContentCell", bundle: nil)
        self.movieTableView.register(nib, forCellReuseIdentifier: "cell")
    }
}

extension MovieChooserViewController: UITableViewDataSource {
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
}

extension MovieChooserViewController: UITableViewDelegate {
    
}

extension MovieChooserViewController: MovieChooserView {
    func startLoading() {
        
    }
    
    func finishLoading() {
        
    }
    
    func setMovies(movieList: [Movie]) {
        contentList = movieList[0..<3]
        movieTableView.reloadData()
    }
}
