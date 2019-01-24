//
//  Layout.swift
//  Funny
//
//  Created by Robby Klein on 1/23/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class Layout: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Main BG color
        view.backgroundColor = UIColor.App.background
        
        // Hide Navbar
        navigationController?.isNavigationBarHidden = true
    }
    
    // Close keyboard on tap outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
}
