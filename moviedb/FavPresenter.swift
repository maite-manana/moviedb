//
//  FavPresenter.swift
//  moviedb
//
//  Created by Maite Mañana on 7/3/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreData

class FavPresenter {
    fileprivate var favView: FavView?

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var favs: [Fav] = []
    
    func attachView(_ view:FavView) {
        favView = view
    }
    
    func detachView() {
        favView = nil
    }
    
    func getContent() {
      favView?.startLoading()
        let favsfetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Fav")
        do {
            favs = try context.fetch(favsfetch) as! [Fav]
        } catch {
            fatalError("Error: \(error)")
        }
        favView?.finishLoading()
        favView?.setContent(favsList: favs)
    }
}
