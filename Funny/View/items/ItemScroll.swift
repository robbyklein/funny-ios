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
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.App.background

    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSize(parent: UIView) {
        self.widthAnchor.constraint(equalTo: parent.widthAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: parent.heightAnchor, constant: -60).isActive = true
        self.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: parent.leftAnchor).isActive = true
    }
}
