//
//  Item.swift
//  Funny
//
//  Created by Robby Klein on 1/23/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import Foundation

struct Item:Decodable {
    let id:Int
    let tags:[String]
    let source:String
    let published:Bool
}

struct Items:Decodable {
    let items: [Item]
    let pages: Int
}
