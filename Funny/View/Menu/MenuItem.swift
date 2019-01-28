//
//  MenuItem.swift
//  Funny
//
//  Created by Robby Klein on 1/27/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class MenuItem: UIButton {
    let right = Image()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(title: String, to: UIViewController) {
        self.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor.App.primaryText, for: .normal)
        self.setTitleColor(UIColor.App.primaryTextHighlight, for: .highlighted)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        self.contentHorizontalAlignment = .left
        self.addSubview(right)

        right.image = UIImage(named: "right")
        right.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        right.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setWidth(parent: UIView) {
        self.widthAnchor.constraint(equalTo: parent.widthAnchor, constant: -40).isActive = true
    }
}
