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
        let logo = UIBarButtonItem(image: UIImage(named: "logo"), style: .plain, target: self, action: #selector(handleLogo))
        self.navigationItem.leftBarButtonItem = logo
        
        // Burger/Back Button
        if (close) {
            let close = UIBarButtonItem(image: UIImage(named: "close"), style: .plain, target: self, action: #selector(handleMenuClose))
            self.navigationItem.rightBarButtonItem = close
        } else {
            let menu = UIBarButtonItem(image: UIImage(named: "hamburger"), style: .plain, target: self, action: #selector(handleMenu))
            self.navigationItem.rightBarButtonItem = menu
        }
    }
    
    @objc func handleMenu() {
        navigationController?.pushViewController(MenuController(), animated: true)
    }
    
    @objc func handleMenuClose() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleLogo() {
        // Go to latest only if elsewhere
        if !(navigationController?.topViewController is LatestController) {
            navigationController?.pushViewController(LatestController(), animated: true)

        }
    }
}

