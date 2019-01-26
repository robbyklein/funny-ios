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
    

    let thumbsUp = UIButton(type: .system)
    let thumbsUpIcon = UIImage(named: "thumbs_up")
    
    let thumbsDown = UIButton(type: .system)
    let thumbsDownIcon = UIImage(named: "thumbs_down")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.App.primary
        self.addSubview(stack)
        
        share.setImage(shareIcon, for: .normal)
        share.tintColor = UIColor.App.primaryText
        
        shuffle.setImage(shuffleIcon, for: .normal)
        shuffle.tintColor = UIColor.App.primaryText
        
        thumbsUp.setImage(thumbsUpIcon, for: .normal)
        thumbsUp.tintColor = UIColor.App.primaryText
        
        thumbsDown.setImage(thumbsDownIcon, for: .normal)
        thumbsDown.tintColor = UIColor.App.primaryText
        
        stack.addArrangedSubview(share)
        stack.addArrangedSubview(shuffle)
        stack.addArrangedSubview(thumbsDown)
        stack.addArrangedSubview(thumbsUp)
        
        stack.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -60).isActive = true
        stack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true


    }
    

    convenience init() {
        self.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSize(parent: UIView) {
        self.widthAnchor.constraint(equalTo: parent.widthAnchor).isActive = true
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.bottomAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: parent.leftAnchor).isActive = true
    }
}
