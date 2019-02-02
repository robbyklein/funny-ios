//
//  ItemsController.swift
//  Funny
//
//  Created by Robby Klein on 1/23/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class ItemsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    // -----------------------------
    // MARK: Properties / Elements
    // -----------------------------
    
    // Cell Id
    let cellId = "itemCell"
    
    // Store Array of Items
    var items = [Item]()
    
    // Bottom action bar
    let actionbar = ItemActionBar()

    // -----------------------------
    // MARK: Initiation
    // -----------------------------
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    convenience init() {
        // Set up layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        self.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register Cell
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: cellId)
        
        
        // Snapping
        collectionView.isPagingEnabled = true
        
        // add logo to nav
        navigationItem.title = "Latest"
        self.setupNav()
        
        // Style Elements
        self.setupView()
        
        // Events
        actionbar.share.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShare)))
        actionbar.shuffle.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShuffle)))
        actionbar.add.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleFavorite)))

    }
    
    // -----------------------------
    // MARK: Load Items
    // -----------------------------
    func loadItems(items: [Item]) {
        self.items = items
        
        DispatchQueue.main.async() {
            self.collectionView.reloadData()
        }
    }
    
    // -----------------------------
    // MARK: Event Handlers
    // -----------------------------

    @objc func handleShare() {
        // Get active item
        let cellIndexes = collectionView.indexPathsForVisibleItems
        
        if cellIndexes.count > 0 {
            let cellIndex = cellIndexes[0]
            let cell = collectionView.cellForItem(at: cellIndex) as! ItemCell

            // image to share
            if let image = cell.imageView.image {
                // set up activity view controller
                let imageToShare = [ image ]
                let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
                
                // exclude some activity types from the list (optional)
                activityViewController.excludedActivityTypes = [
                    UIActivity.ActivityType.postToVimeo,
                    UIActivity.ActivityType.addToReadingList,
                    UIActivity.ActivityType.markupAsPDF,
                ]
                
                // present the view controller
                self.present(activityViewController, animated: true, completion: nil)
            }
        }
    }
    
    @objc func handleShuffle() {
        // Get active item(s)
        let cellIndexes = collectionView.indexPathsForVisibleItems
        
        if cellIndexes.count > 0 {
            // Get the cell index
            let cellIndex = Int(cellIndexes[0][1])
            
            if cellIndex != self.items.count-1 {
                // Create shuffled array of unseen items
                let shuffled = Array(self.items[cellIndex+1...self.items.count-1]).shuffled()

                // New array of only past and current items
                var newItems = Array(self.items[0...cellIndex])

                // Append the shuffled items
                newItems.append(contentsOf: shuffled)
                
                // Set items
                self.items = newItems

                // Reload collection view
                collectionView.reloadData()
            }
        }
    }
    
    @objc func handleFavorite() {
        // Get active item
        let cellIndexes = collectionView.indexPathsForVisibleItems
        
        if cellIndexes.count > 0 {
            let item = self.items[Int(cellIndexes[0][1])]
            let cell = collectionView.cellForItem(at: cellIndexes[0]) as! ItemCell
            
            if let source = item.source {
                let ex = source.suffix(4).lowercased()
                
                if let image = cell.imageView.image {
                    if let imageData = ex == ".png" ? image.pngData() : image.jpegData(compressionQuality: 1) {
                        // Create favorite
                        let favorite = Favorite(context: Core.context)
                        favorite.id = Int16(item.id)
                        favorite.image = imageData as NSData
                        
                        // Save it
                        Core.saveContext()
                    }
                }
            }
        }
    }
    
    // -----------------------------
    // MARK: Stylistic
    // -----------------------------

    func setupView() {
        view.addSubview(actionbar)
        actionbar.setSize(parent: view)
    }
    
    // -----------------------------
    // MARK: Collection View Methods
    // -----------------------------
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ItemCell
        
        if let source = item.source {
            let imageUrl = ApiRoutes.imageUrl(path: source)
            cell.setImage(url: imageUrl)
        }
        
        if let data = item.image {
            cell.loadImage(data: data)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: view.safeAreaLayoutGuide.layoutFrame.height)
    }
}
