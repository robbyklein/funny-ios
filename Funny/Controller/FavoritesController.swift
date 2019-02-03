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
    var favorites = [Favorite]() // Store favorites for deletion
    
    func itemsArray(favorites: [Favorite]) -> [Item] {
        var items = [Item]()
        
        for item in favorites {
            // Init an item
            let item = Item(favorite: item)
            
            // Push to items array
            items.append(item)
        }
        
        return items
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set navigation title
        navigationItem.title = "Favorites"
        
        // Add remove button to actionbar
        self.actionbar.removeFromFavorites()
        
        // The fetch request
        let fetch:NSFetchRequest = Favorite.fetchRequest()
        
        // Fetch the tasks
        do {
            let favorites = try Core.context.fetch(fetch)
            
            // Set on class
            self.favorites = favorites
            
            // Create array of items
            let items = itemsArray(favorites: favorites)
            
            // Load items into parent collection view
            super.loadItems(items: items)
            
        } catch {
            print(error.localizedDescription)
        }
        
        // Tap Events
        self.actionbar.sub.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleRemoveFavorites)))
    }
    
    @objc func handleRemoveFavorites() {
        // Get active index
        if let index = getActiveItemIndex() {
            // Get favorite object
            let favorite = favorites[index]
            
            // Delete it
            Core.context.delete(favorite)
            
            do {
                // Save changes
                try Core.context.save()
                
                // Remove from local class
                self.favorites.remove(at: index)
                
                // Create a new array of items
                let items = itemsArray(favorites: self.favorites)
                
                // Reload items
                self.loadItems(items: items)
                
                // Success Message
                self.flash(view: self.actionbar, message: "Removed from favorites")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
