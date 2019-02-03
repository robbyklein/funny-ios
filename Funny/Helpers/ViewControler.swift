//
//  ViewControler.swift
//  Funny
//
//  Created by Robby Klein on 2/3/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit


extension UIViewController {
    func flash(view: UIView, message : String) {
        let label = UILabel()
        self.view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 200).isActive = true
        label.heightAnchor.constraint(equalToConstant: 45).isActive = true
        label.bottomAnchor.constraint(equalTo: view.topAnchor, constant: -20).isActive = true
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.backgroundColor =  UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.8)
        label.textColor = UIColor.App.primary
        label.textAlignment = .center;
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = message
        label.layer.cornerRadius = 5;
        label.clipsToBounds  =  true
        
        UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
            label.alpha = 0.0
        }, completion: {(isCompleted) in
            label.removeFromSuperview()
        })
    }
}

