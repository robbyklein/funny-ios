//
//  Stack.swift
//  Funny
//
//  Created by Robby Klein on 1/24/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class Stack: UIStackView {
    override init(frame: CGRect) {
        // Init UIStackView
        super.init(frame: .zero)
        
        // Allow auto layout constraints
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(axis: NSLayoutConstraint.Axis, spacing: CGFloat, distribution: UIStackView.Distribution) {
        self.init(frame: .zero)
        
        // Set settings
        self.spacing = spacing
        self.axis = axis
        self.distribution = distribution
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
