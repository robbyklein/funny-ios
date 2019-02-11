//
//  ApiRoutes.swift
//  Funny
//
//  Created by Robby Klein on 1/23/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import Foundation

// Makes url changes easy!
struct ApiRoutes {
    static let root = "http://rfunny.us-east-2.elasticbeanstalk.com"
    static let fetchItems = "\(ApiRoutes.root)/api/items"
    static let fetchTags = "\(ApiRoutes.root)/api/tags"
    
    static func fetchTagItems(id: Int, page: Int) -> String {
        return "\(ApiRoutes.root)/api/items/tag/\(id)/page/\(page)"
    }
}
