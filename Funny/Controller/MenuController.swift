//
//  MenuController.swift
//  Funny
//
//  Created by Robby Klein on 1/27/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class MenuController: UIViewController {
    let nav = Stack(axis: .vertical, spacing: 30, distribution: .equalSpacing)
    let latest = MenuItem(title: "Latest", to: HomeController())
    let favorites = MenuItem(title: "Favorites", to: HomeController())
    let about = MenuItem(title: "About", to: HomeController())

    override func viewDidLoad() {
        self.setupNav(close: true)
        view.backgroundColor = UIColor.App.primary
        
        view.addSubview(nav)
        nav.addArrangedSubview(latest)
        nav.addArrangedSubview(favorites)
        nav.addArrangedSubview(about)
        
        nav.topLeft(parent: view, leftConstant: 20, topConstant: 40)
        
        latest.setWidth(parent: view)
        favorites.setWidth(parent: view)
        about.setWidth(parent: view)
    }
}
