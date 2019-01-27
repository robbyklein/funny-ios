//
//  View.swift
//  Funny
//
//  Created by Robby Klein on 1/27/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

extension UIView {
    func fullCoverage(parent: UIView, heightConstant: CGFloat, widthConstant: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: parent.widthAnchor, constant: widthConstant).isActive = true
        self.heightAnchor.constraint(equalTo: parent.heightAnchor, constant: heightConstant).isActive = true
        self.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: parent.leftAnchor).isActive = true
    }
    
    func centerCenter(parent: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
    }
    
    func setSize(widthConstant: CGFloat, heightConstant: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
        self.heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
    }
}
