//
//  SetupNav.swift
//  Funny
//
//  Created by Robby Klein on 1/25/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

extension UIViewController {
    func setupNav() {
        let logo = Image()
        logo.image = UIImage(named: "logo")
        logo.setSize(width: 40.8, height: 20)
        
        self.navigationItem.titleView = logo
    }
}
