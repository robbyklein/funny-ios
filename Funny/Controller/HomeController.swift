//
//  HomeController.swift
//  Funny
//
//  Created by Robby Klein on 1/23/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class HomeController: Swiper {
    // Cell Id
    let cellId = "itemCell"
    
    // Store Array of Items
    var items = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register Cell
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: cellId)
        
        // Fetch data
        Networking.shared.fetchJson(url: ApiRoutes.fetchItems) { (items:Items) in
            self.items = items.items
            
            DispatchQueue.main.async() {
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: Collection View Methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ItemCell
        
        let imageUrl = ApiRoutes.imageUrl(path: item.source)
    
        
        cell.setImage(url: imageUrl)

        return cell
    }
    
}

