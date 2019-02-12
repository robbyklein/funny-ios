//
//  ItemsController.swift
//  Funny
//
//  Created by Robby Klein on 1/23/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class ItemsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    // Properties
    let cellId = "itemCell"
    var items = [Item]()
    var finished = false
    var page = 1
    var type:String?
    
    // Elements
    let actionbar = ItemActionBar()
    
    // Initiation
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    convenience init() {
        // Set up layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        // Init collection view controller
        self.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Load in items
    func loadItems(items: [Item]) {
        self.items += items
        
        // Refresh collection view
        DispatchQueue.main.async() {
            self.collectionView.reloadData()
        }
    }
    
    // MARK: View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register Cell
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: cellId)
        
        // Enable Snapping
        collectionView.isPagingEnabled = true
        
        // Add nav buttons
        self.setupNav()
        
        // Style Elements
        self.setupView()
        
        // Add tap events to action bar
        actionbar.share.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShare)))
        actionbar.shuffle.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShuffle)))
        actionbar.add.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleFavorite)))
    }
    
    func fetchItems(url: String) {
        Networking.shared.fetchJson(url: url) { (items:Items?, error:Error?) in
            // Something went wrong
            if (error != nil) {
                if let error = error?.localizedDescription {
                    print(error)
                }
                return
            }
            
            if let items = items {
                // Load items into parent collection view
                self.loadItems(items: items.items)
                
                if self.page == items.pages {
                    self.finished = true
                }  else {
                     self.page += 1
                }

                print(self.page, self.finished)
            }
        }
    }
    
    func setupView() {
        // Add actionbar to view
        view.addSubview(actionbar)
        
        // Set it's size relative to view
        actionbar.setSize(parent: view)
    }
    
    // MARK: Class Helpers
    func getActiveCell() -> ItemCell? {
        // Get active indexes
        let cellIndexes = collectionView.indexPathsForVisibleItems
        
        // Make sure there is an active index
        if cellIndexes.count > 0 {
            // Get the first/only in array (only 1 cell shows at a time)
            let cellIndex = cellIndexes[0]
            
            // Grab the cell
            let cell = collectionView.cellForItem(at: cellIndex) as! ItemCell
            
            // Return it
            return cell
        }
        
        return nil
    }
    
    func getActiveItem() -> Item? {
        // Get active indexes
        let cellIndexes = collectionView.indexPathsForVisibleItems
        
        // Make sure they exist
        if cellIndexes.count > 0 {
            // Get item the cell represents
            let itemIndex = Int(cellIndexes[0][1])
            let item = self.items[itemIndex]
            
            return item
        }
        
         return nil
    }
    
    func getActiveItemIndex() -> Int? {
        // Get active indexes
        let cellIndexes = collectionView.indexPathsForVisibleItems
        
        // Make sure they exist
        if cellIndexes.count > 0 {
            // Get item the cell represents
            let itemIndex = Int(cellIndexes[0][1])
            return itemIndex
        }
        
        return nil
    }
    
    // MARK: Event Handlers
    @objc func handleShare() {
        if let cell = getActiveCell() {
            // Check that cell has an image
            if let image = cell.imageView.image {
                // set up activity view controller
                let imageToShare = [image] // Share the cell's image
                let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view // Apparently prevents iPad crash
                
                // exclude some activity types
                activityViewController.excludedActivityTypes = [
                    UIActivity.ActivityType.postToVimeo,
                    UIActivity.ActivityType.addToReadingList,
                    UIActivity.ActivityType.markupAsPDF,
                ]
                
                // present the share view controller
                self.present(activityViewController, animated: true, completion: nil)
            }
        }
    }
    
    @objc func handleShuffle() {
        // Get active indexes
        let cellIndexes = collectionView.indexPathsForVisibleItems
        
        // Make sure indexes exist
        if cellIndexes.count > 0 {
            // Get the cell index
            let cellIndex = Int(cellIndexes[0][1])
            
            // Make sure we're not on the very last cell
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
                
                // Success Message
                self.flash(view: self.actionbar, message: "Items shuffled!")
            }
        }
    }
    
    @objc func handleFavorite() {
        // Get active indexes
        let cellIndexes = collectionView.indexPathsForVisibleItems
        
        // Make sure they exist
        if cellIndexes.count > 0 {
            // Get item the cell represents
            let itemIndex = Int(cellIndexes[0][1])
            let item = self.items[itemIndex]
            
            // Get the actual cell
            let cell = collectionView.cellForItem(at: cellIndexes[0]) as! ItemCell
            
            // If item has a source url
            if let source = item.source {
                // is it a png or jpg?
                let ex = source.suffix(4).lowercased()
                
                // Get image if it exists
                if let image = cell.imageView.image {
                    // get the image data
                    if let imageData = ex == ".png" ? image.pngData() : image.jpegData(compressionQuality: 1) {
                        // Create favorite
                        let favorite = Favorite(context: Core.context)
                        favorite.id = Int16(item.id)
                        favorite.image = imageData as NSData
                        
                        // Save it
                        Core.saveContext()
                        
                        // Remove item
                        self.items.remove(at: itemIndex)
                        
                        // Refresh collection view
                        collectionView.reloadData()
                        
                        // Success message
                        self.flash(view: actionbar, message: "Added to Favorites")
                    }
                }
            }
        }
    }
        
    // MARK: Collection View Methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Get the item
        let item = items[indexPath.row]
        
        // Create a cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ItemCell
        
        // If its a url fetch and set
        if let source = item.source {
            cell.setImage(url: source)
        }
        
        // If image is in coredata (item is a Favorite), load it
        print(indexPath.row)
        if let data = item.image {
            cell.loadImage(data: data)
        }
        
//        if
//        - not on favorites
//        - first page loaded
//        - 5 away from end
//        - next page exists

        if (item.image == nil && indexPath.row > 0 && indexPath.row == items.count - 5 && !finished) {
            self.fetchItems(url: ApiRoutes.fetchItems(page: self.page))
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

