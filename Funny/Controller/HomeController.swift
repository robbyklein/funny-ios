//
//  HomeController.swift
//  Funny
//
//  Created by Robby Klein on 1/23/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class HomeController: Layout {
    var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetch items
        JSON.shared.fetchJson(url: ApiRoutes.fetchItems) { (items:Items) in
            self.items = items
        }
    }
}

