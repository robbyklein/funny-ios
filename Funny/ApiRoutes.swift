//
//  ApiRoutes.swift
//  Funny
//
//  Created by Robby Klein on 1/23/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import Foundation

struct ApiRoutes {
    static let root = "http://localhost:3000"
    static let fetchItems = "\(ApiRoutes.root)/api/items"
    
    static func imageUrl(path: String) -> String {
        return ApiRoutes.root + path
    }
}
