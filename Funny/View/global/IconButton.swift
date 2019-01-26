//
//  IconButton.swift
//  Funny
//
//  Created by Robby Klein on 1/26/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class IconButton: UIButton {
    let icon = Image()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        icon.setSize(width: 20, height: 20)
        icon.image = UIImage(named: "share")
    
        
        self.addSubview(icon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
