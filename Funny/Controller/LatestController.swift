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
        super.viewDidLoad()
        
        // Fetch data
        Networking.shared.fetchJson(url: ApiRoutes.fetchItems) { (items:Items?, error:Error?) in
            if (error != nil) {
                if let error = error?.localizedDescription {
                    print(error)
                }
                return
            }
            
            if let items = items {
                super.loadItems(items: items.items)
            }
        }
    }
}
