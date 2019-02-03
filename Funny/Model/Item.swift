//
//  Item.swift
//  Funny
//
//  Created by Robby Klein on 1/23/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import Foundation
import UIKit

struct Item:Decodable {
    let id:Int
    let source:String?
    let published:Bool
    let image:Data?
    
    // Create item from a favorite
    init(favorite: Favorite) {        
        self.id = Int(favorite.id)
        self.source = nil
        self.published = favorite.published
        self.image = favorite.image as Data
    }
}

struct Items:Decodable {
    let items: [Item]
    let pages: Int
}
