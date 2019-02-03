//
//  View.swift
//  Funny
//
//  Created by Robby Klein on 1/27/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

extension UIView {
    // Make view cover 100% of parents size
    func fullCoverage(parent: UIView, heightConstant: CGFloat, widthConstant: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: parent.widthAnchor, constant: widthConstant).isActive = true
        self.heightAnchor.constraint(equalTo: parent.heightAnchor, constant: heightConstant).isActive = true
        self.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: parent.leftAnchor).isActive = true
    }
    
    // Center horizontally and vertically
    func centerCenter(parent: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
    }
    
    // Set the width/height to contants
    func setSize(widthConstant: CGFloat, heightConstant: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
        self.heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
    }
    
    // Place view on the top left corner of parent
    func topLeft(parent: UIView, leftConstant: CGFloat, topConstant: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: parent.topAnchor, constant: topConstant).isActive = true
        self.leftAnchor.constraint(equalTo: parent.leftAnchor, constant: leftConstant).isActive = true
    }
}
