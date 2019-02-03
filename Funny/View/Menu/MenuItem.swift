//
//  MenuItem.swift
//  Funny
//
//  Created by Robby Klein on 1/27/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class MenuItem: UIButton {
    // Image view for right arrow
    let right = Image()
    
    // Initiate UIButton
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(title: String, to: UIViewController) {
        self.init(frame: .zero)
        
        // Add image to button
        self.addSubview(right)

        // Allow auto layout constraints
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // Set the title
        self.setTitle(title, for: .normal)
        
        // Style the UIButton
        self.setTitleColor(UIColor.App.primaryText, for: .normal)
        self.setTitleColor(UIColor.App.primaryTextHighlight, for: .highlighted)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        self.contentHorizontalAlignment = .left
        
        // Style the image
        right.image = UIImage(named: "right")
        right.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        right.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setWidth(parent: UIView) {
        // Sets the width with 20px margins on each side
        self.widthAnchor.constraint(equalTo: parent.widthAnchor, constant: -40).isActive = true
    }
}
