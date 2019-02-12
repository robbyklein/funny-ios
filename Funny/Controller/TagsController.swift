//
//  TagsController.swift
//  Funny
//
//  Created by Robby Klein on 1/24/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class TagsController: UIViewController {
    // Menu Elements
    let scroll = UIScrollView()
    let nav = Stack(axis: .vertical, spacing: 30, distribution: .equalSpacing)
    var tags = [Tag]()
    
    override func viewDidLoad() {
        // Show X on nav instead of burger
        self.setupNav(close: true)
        
        // Set the view background color
        view.backgroundColor = UIColor.App.primary
        
        // Add elements to view
        view.addSubview(scroll)
        
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scroll.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        scroll.addSubview(nav)
        
        nav.topLeft(parent: scroll, leftConstant: 20, topConstant: 40)
        nav.bottomAnchor.constraint(equalTo: scroll.bottomAnchor).isActive = true // this makes it scrollable

        // Style/Position Elements        
        // Fetch data
        Networking.shared.fetchJson(url: ApiRoutes.fetchTags) { (tags:Tags?, error:Error?) in
            // Something went wrong
            if (error != nil) {
                if let error = error?.localizedDescription {
                    print(error)
                }
                return
            }
            
            if let tags = tags {
                // Load items into parent collection view
                self.tags = tags.tags
                
                DispatchQueue.main.async() {
                    self.addMenuItems()
                }
            }
        }
    }
    
    func addMenuItems() {
        for (index, tag) in self.tags.enumerated() {
            // Add a menu item to stack view
            let navItem = MenuItem(title: tag.title.capitalized)
            navItem.tag = index
            self.nav.addArrangedSubview(navItem)
            navItem.setWidth(parent: self.view)
            
            // Add tap event listenr
            navItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTag)))
        }
    }
    
    @objc func handleTag(tapGesture: UITapGestureRecognizer) {
        if let view = tapGesture.view {
            // Fetch the tag object using index
            let tag = self.tags[Int(view.tag)]
            
            // Set props on the view controller before loading
            let viewController = TagItemsController()
            viewController.tagId = tag.id
            viewController.tagName = tag.title.capitalized
            
            // Navigate to it
            navigationController?.pushViewController(viewController, animated: true)

        }
    }
}
