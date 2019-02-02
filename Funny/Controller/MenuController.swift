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
    let latest = MenuItem(title: "Latest", to: LatestController())
    let favorites = MenuItem(title: "Favorites", to: LatestController())
    let about = MenuItem(title: "About", to: LatestController())

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
        
        // Tap Events
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
