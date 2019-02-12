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
    var page = 1
    
    override func viewDidLoad() {
        // Setup collection view
        super.viewDidLoad()
        
        // Set navigation title
        navigationItem.title = self.tagName
        
        // Add add button to actionbar
        self.actionbar.addToFavorites()
        
        // Fetch data
        if let tagId = tagId {
            let url = ApiRoutes.fetchTagItems(id: tagId, page: self.page)
            
            Networking.shared.fetchJson(url: url) { (items:Items?, error:Error?) in
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
}
