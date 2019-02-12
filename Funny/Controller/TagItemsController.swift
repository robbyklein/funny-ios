//
//  TagItemsController.swift
//  Funny
//
//  Created by Robby Klein on 2/12/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class TagItemsController: ItemsController {
    var tagId:Int?
    var tagName:String?
    
    override func viewDidLoad() {
        // Setup collection view
        super.viewDidLoad()
        
        // Set navigation title
        navigationItem.title = self.tagName
        
        // Add add button to actionbar
        self.actionbar.addToFavorites()
        
        // Fetch data
        if let tagId = tagId {
            let url = ApiRoutes.fetchTagItems(id: tagId, page: super.page)
            super.fetchItems(url: url)
        }

    }
}
