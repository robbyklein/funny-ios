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
        
        // Set navigation title
        navigationItem.title = "Favorites"
        
        // The fetch request
        let fetch:NSFetchRequest = Favorite.fetchRequest()
        
        // Fetch the tasks
        do {
            let favorites = try Core.context.fetch(fetch)
            
            // Convert to an array of Items
            var items = [Item]()
            
            for item in favorites {
                // Init an item
                let item = Item(favorite: item)
                
                // Push to items array
                items.append(item)
            }
            
            // Load items into parent collection view
            super.loadItems(items: items)
        } catch {
            print(error.localizedDescription)
        }
    }
}
