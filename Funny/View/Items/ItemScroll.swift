//
//  ItemScroll.swift
//  Funny
//
//  Created by Robby Klein on 1/24/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class ItemScroll: UIScrollView {
    override init(frame: CGRect) {
        // Init UIScrollvVew
        super.init(frame: .zero)
        
        // All autolayout constraints
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // Set the background color
        self.backgroundColor = UIColor.App.background

    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
