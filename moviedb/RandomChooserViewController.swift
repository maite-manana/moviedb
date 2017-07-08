//
//  RandomChooserViewController.swift
//  moviedb
//
//  Created by Ines on 6/27/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import UIKit

class RandomChooserViewController : UIViewController {
    
    fileprivate var randomChooserPresenter = RandomChooserPresenter()
    
    @IBOutlet weak var genresTableView: UITableView!
    
    var genresList: [Genre] = []
    var genreSelected: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genresTableView.dataSource = self
        genresTableView.delegate = self
        
        randomChooserPresenter.attachView(self)
        randomChooserPresenter.getGenres()
        
        let nib = UINib(nibName: "GenreCell", bundle: nil)
        self.genresTableView.register(nib, forCellReuseIdentifier: "cell")
        
    }
    
    @IBAction func search(_ sender: Any) {
        self.performSegue(withIdentifier: "movieChooserList", sender: self)
    }
  
}

extension RandomChooserViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.genresList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! GenreCell
        cell.configure(genre: genresList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (genreSelected.count > 2) {
            MessageHandler.showMessage(title: "Error", body: "Debes elegir entre 1 y 3 géneros", type: messageType.ERROR)
        } else {
            let currentCell = tableView.cellForRow(at: indexPath) as!GenreCell
            genreSelected.append(String(genresList[indexPath.row].id!))
            currentCell.checked.isHidden = false
            currentCell.checked.text = "check"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let movieChooserViewController = segue.destination as! MovieChooserViewController
        movieChooserViewController.selectedGenre = genreSelected
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50.0
    }
  
}

extension RandomChooserViewController : UITableViewDelegate {
    
}

extension RandomChooserViewController : RandomChooserView {
    func startLoading() {
    }
    
    func finishLoading() {
    }
    
    func setGenres(genreList: [Genre]) {
        genresList = genreList
        genresTableView.reloadData()
    }
    
    func setRandom(movieList: [Movie]) {
        
    }
}
