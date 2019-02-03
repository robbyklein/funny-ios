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
    let stack = Stack(axis: .horizontal, spacing: 10, distribution: .equalSpacing)
    let share = UIButton(type: .system)
    let shareIcon = UIImage(named: "share")
    let shuffle = UIButton(type: .system)
    let shuffleIcon = UIImage(named: "dice")
    let add = UIButton(type: .system)
    let addIcon = UIImage(named: "plus")
    
    let sub = UIButton(type: .system)
    let subIcon = UIImage(named: "minus")

    override init(frame: CGRect) {
        // Init UIView
        super.init(frame: frame)
        
        // Allow autolayout constraints
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // Set the background color
        self.backgroundColor = UIColor.App.primary
        
        // Add elements to view
        self.addSubview(stack)
        share.setImage(shareIcon, for: .normal)
        share.tintColor = UIColor.App.primaryText
        shuffle.setImage(shuffleIcon, for: .normal)
        shuffle.tintColor = UIColor.App.primaryText
        add.setImage(addIcon, for: .normal)
        add.tintColor = UIColor.App.primaryText
        sub.setImage(subIcon, for: .normal)
        sub.tintColor = UIColor.App.primaryText
        stack.addArrangedSubview(share)
        stack.addArrangedSubview(shuffle)
        
        // Style/Position elements in view
        stack.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -60).isActive = true
        stack.centerCenter(parent: self)
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    func addToFavorites() {
        stack.addArrangedSubview(add)
    }
    
    func removeFromFavorites() {
        stack.addArrangedSubview(sub)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Size size and position
    func setSize(parent: UIView) {
        self.widthAnchor.constraint(equalTo: parent.widthAnchor).isActive = true
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.bottomAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: parent.leftAnchor).isActive = true
    }
}
