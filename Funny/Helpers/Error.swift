//
//  Error.swift
//  Funny
//
//  Created by Robby Klein on 1/26/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import Foundation

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
