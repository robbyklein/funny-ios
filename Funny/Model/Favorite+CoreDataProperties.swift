//
//  Favorite+CoreDataProperties.swift
//  Funny
//
//  Created by Robby Klein on 2/1/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var id: Int16
    @NSManaged public var image: NSData
    @NSManaged public var published: Bool

}
