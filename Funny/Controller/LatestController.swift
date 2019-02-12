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
        
        super.type = "latest"
        
        // Set navigation title
        navigationItem.title = "Latest"
        
        // Add add button to actionbar
        self.actionbar.addToFavorites()
        
        // Fetch data
        let url = ApiRoutes.fetchItems(page: super.page)
        super.fetchItems(url: url)
    }
}
