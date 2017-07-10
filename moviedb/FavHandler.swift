//
//  FavHandler.swift
//  moviedb
//
//  Created by Maite Mañana on 7/10/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class FavHandler {
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static var isFav: Bool!
    static var favElem: [NSManagedObject] = []

    class func checkIfFavorite(id: Int) -> Bool {
        let predicate = NSPredicate(format: "id == %@", id as NSNumber)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Fav")
        fetchRequest.predicate = predicate
        
        do {
            favElem = try context.fetch(fetchRequest) as! [NSManagedObject]
        } catch {}
        isFav = !favElem.isEmpty
        return isFav
        
    }
    
    class func addFav(id: Int, title: String, posterPath: String, overview: String) -> String{
        if checkIfFavorite(id: id) {
            context.delete(favElem[0] as NSManagedObject)
            do {
                try context.save()
                return Constants.FavResults.kUnFavSuccess
            } catch {
                return Constants.FavResults.kUnFavError
            }
        } else {
            let fav = NSEntityDescription.insertNewObject(forEntityName: "Fav", into:self.context) as! Fav
            fav.id = Int32(id)
            fav.title = title
            fav.posterPath = posterPath
            fav.overview = overview
            
            do {
                try context.save()
                return Constants.FavResults.kFavSuccess
            } catch {
                return Constants.FavResults.kFavError
            }
        }
    }

    
    
}
