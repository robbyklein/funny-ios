//
//  LatestController.swift
//  Funny
//
//  Created by Robby Klein on 1/31/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class LatestController: ItemsController {
    override func viewDidLoad() {
        // Setup collection view
        super.viewDidLoad()
        
        // Set navigation title
        navigationItem.title = "Latest"
        
        // Add add button to actionbar
        self.actionbar.addToFavorites()
        
        // Fetch data
        Networking.shared.fetchJson(url: ApiRoutes.fetchItems) { (items:Items?, error:Error?) in
            // Something went wrong
            if (error != nil) {
                if let error = error?.localizedDescription {
                    print(error)
                }
                return
            }
            
            if let items = items {
                // Load items into parent collection view
                super.loadItems(items: items.items)
            }
        }
    }
}
