//
//  ItemActionBar.swift
//  Funny
//
//  Created by Robby Klein on 1/25/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class ItemActionBar: UIView {
    // Elements
    let stack = Stack(axis: .horizontal, spacing: 10)
    let share = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .black
        self.addSubview(stack)

        share.setTitle("share", for: .normal)
        share.setTitleColor(.white, for: .normal)
        
        stack.addArrangedSubview(share)
        
    }
    

    convenience init() {
        self.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSize(parent: UIView) {
        self.widthAnchor.constraint(equalTo: parent.widthAnchor).isActive = true
        self.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: parent.leftAnchor).isActive = true
    }
}
