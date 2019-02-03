//
//  MenuController.swift
//  Funny
//
//  Created by Robby Klein on 1/27/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class MenuController: UIViewController {
    // Menu Elements
    let nav = Stack(axis: .vertical, spacing: 30, distribution: .equalSpacing)
    let latest = MenuItem(title: "Latest", to: LatestController())
    let favorites = MenuItem(title: "Favorites", to: LatestController())
    let about = MenuItem(title: "About", to: LatestController())

    override func viewDidLoad() {
        // Show X on nav instead of burger
        self.setupNav(close: true)
        
        // Set the view background color
        view.backgroundColor = UIColor.App.primary
        
        // Add elements to view
        view.addSubview(nav)
        nav.addArrangedSubview(latest)
        nav.addArrangedSubview(favorites)
        nav.addArrangedSubview(about)
        
        // Style/Position Elements
        nav.topLeft(parent: view, leftConstant: 20, topConstant: 40)
        latest.setWidth(parent: view)
        favorites.setWidth(parent: view)
        about.setWidth(parent: view)
        
        // Add tap Events
        latest.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLatest)))
        favorites.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleFavorites)))
        about.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAbout)))
    }
    
    @objc func handleLatest() {
        navigationController?.pushViewController(LatestController(), animated: true)
    }
    
    @objc func handleFavorites() {
        navigationController?.pushViewController(FavoritesController(), animated: true)
    }
    
    @objc func handleAbout() {
        navigationController?.pushViewController(AboutController(), animated: true)
    }
}
