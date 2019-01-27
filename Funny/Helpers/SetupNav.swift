//
//  SetupNav.swift
//  Funny
//
//  Created by Robby Klein on 1/25/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

extension UIViewController {

    
    func setupNav(close:Bool = false) {
        // Add logo
        let logo = Image()
        logo.image = UIImage(named: "logo")
        logo.setSize(widthConstant: 40.8, heightConstant: 20)
        self.navigationItem.titleView = logo
        
        // Burger/Back Button
        if (close) {
            let close = UIBarButtonItem(image: UIImage(named: "close"), style: .plain, target: self, action: #selector(handleMenuClose))
            self.navigationItem.leftBarButtonItem = close
        } else {
            let menu = UIBarButtonItem(image: UIImage(named: "hamburger"), style: .plain, target: self, action: #selector(handleMenu))
            self.navigationItem.leftBarButtonItem = menu
        }
        

    }
    
    @objc func handleMenu() {
        navigationController?.pushViewController(MenuController(), animated: true)
    }
    
    @objc func handleMenuClose() {
        navigationController?.popViewController(animated: true)
    }
}
