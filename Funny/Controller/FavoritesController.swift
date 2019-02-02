//
//  FavoritesController.swift
//  Funny
//
//  Created by Robby Klein on 2/1/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit
import CoreData

class FavoritesController: ItemsController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // The fetch request
        let fetch:NSFetchRequest = Favorite.fetchRequest()
        
        // Sort by date
//        let date = NSSortDescriptor(key: #keyPath(Favorite.date), ascending: false)
//        fetch.sortDescriptors = [date]

        // Fetch the tasks
        do {
            let favorites = try Core.context.fetch(fetch)
            var items = [Item]()
            
            for item in favorites {
                let item = Item(favorite: item)
                items.append(item)
            }
                        
            super.loadItems(items: items)
        } catch {
            print(error.localizedDescription)
        }
    }
}
