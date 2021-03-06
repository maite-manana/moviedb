//
//  Constants.swift
//  moviedb
//
//  Created by Ines on 6/24/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
  
  struct APIConstants {
    static let kBaseURL     = "https://api.themoviedb.org/3"
    static let kApiKey = "053876183f264d50ee96838f8b56ba91"
    static let kBaseImageURL = "https://image.tmdb.org/t/p/w500"
    static let kBaseYouTube = "https://www.youtube.com/watch?v="
  }
  
  struct Colors {
    static let kBlue      = UIColor(hue: 0.5583, saturation: 1, brightness: 0.79, alpha: 1.0)
    static let kBlueSoft  = UIColor(hue: 0.5583, saturation: 1, brightness: 0.79, alpha: 0.75)
    static let kBlueLight = UIColor(hue: 0.5583, saturation: 1, brightness: 0.79, alpha: 0.5)
    static let kIndigo    = UIColor(rgba: "#3F51B5")
    static let kLightBlue = UIColor(rgba: "#E1F5FE")
  }
  
  struct Messages {
    static let kGenericErrorMessage = "Ha ocurrido un error"
    static let kFavSuccessMessage = "Agregada a favoritos!"
    static let kUnfavSuccessMessage = "Eliminada de favoritos!"
    static let kFavErrorMessage = "No se ha podido agregar la película a favoritos"
    static let kUnfavErrorMessage = "No se ha podido eliminar la película a favoritos"
    static let kNoFilmsZeroState = "No hay películas disponibles"
    static let kNoFilmsTryAgainZeroState = "No hay películas, busca otra vez"
    static let kNoFavsZeroState = "Todavía no tienes favoritos"
  }
    
  struct FavResults {
    static let kFavSuccess = "FAV_SUCCESS"
    static let kFavError = "FAV_ERROR"
    static let kUnFavSuccess = "UNFAV_SUCCESS"
    static let kUnFavError = "UNFAV_ERROR"
        
  }
    
  struct DefaultTexts {
    static let kDefaultTitle = "Título no disponible"
    static let kDefaultOverview = "Descripción no disponible"
  }
}
