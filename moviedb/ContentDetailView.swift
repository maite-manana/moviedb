//
//  ContentDetailView.swift
//  moviedb
//
//  Created by Ines on 6/28/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation

protocol ContentDetailView {
  func showSuccessFavMessage()
  func showErrorFavMessage()
  func showSuccessUnfavMessage()
  func showErrorUnfavMessage()
}
