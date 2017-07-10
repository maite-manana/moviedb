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
  
  @IBOutlet weak var loadingView: UILoadingView!
  @IBOutlet weak var pickerView1: UIPickerView!
  @IBOutlet weak var pickerView3: UIPickerView!
  @IBOutlet weak var pickerView2: UIPickerView!
  var genresList: [Genre] = []
  var genreSelected: [String] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    pickerView1.delegate = self
    pickerView1.dataSource = self
    pickerView2.delegate = self
    pickerView2.dataSource = self
    pickerView3.delegate = self
    pickerView3.dataSource = self
    
    randomChooserPresenter.attachView(self)
    loadingView.setupLoadingIndicator()
    randomChooserPresenter.getGenres()
  }
  
  @IBAction func search(_ sender: Any) {
    self.performSegue(withIdentifier: "movieChooserList", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let movieChooserViewController = segue.destination as! MovieChooserViewController
    genreSelected = []
    if let selectedGenre1 = genresList[pickerView1.selectedRow(inComponent: 0)].id {
        genreSelected.append(String(selectedGenre1))
    }
    if let selectedGenre2 = genresList[pickerView2.selectedRow(inComponent: 0)].id {
        genreSelected.append(String(selectedGenre2))
    }
    if let selectedGenre3 = genresList[pickerView3.selectedRow(inComponent: 0)].id {
        genreSelected.append(String(selectedGenre3))
    }
    
    movieChooserViewController.selectedGenre = genreSelected
  }
  
}

extension RandomChooserViewController : UIPickerViewDataSource, UIPickerViewDelegate {
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return genresList.count
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return genresList[row].name
  }
}

extension RandomChooserViewController : RandomChooserView {
  func startLoading() {
    loadingView.showLoadingIndicator()
  }
  
  func finishLoading() {
    loadingView.hideLoadingIndicator()
  }
  
  func setGenres(genreList: [Genre]) {
    genresList = [Genre()] + genreList
    pickerView1.reloadAllComponents()
    pickerView2.reloadAllComponents()
    pickerView3.reloadAllComponents()
  }
}
