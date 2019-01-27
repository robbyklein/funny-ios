//
//  MenuController.swift
//  Funny
//
//  Created by Robby Klein on 1/27/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class MenuController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = UIColor.App.primary
        self.setupNav(close: true)
    }
}
