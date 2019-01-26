//
//  HomeController.swift
//  Funny
//
//  Created by Robby Klein on 1/23/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
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
        
        // Fetch data        
        Networking.shared.fetchJson(url: ApiRoutes.fetchItems) { (items:Items?, error:Error?) in
            if (error != nil) {
                print(error?.localizedDescription)
                return
            }
            
            if let items = items {
                self.items = items.items
                
                DispatchQueue.main.async() {
                    self.collectionView.reloadData()
                }
            }
        }
        
        // Snapping
        collectionView.isPagingEnabled = true
        
        // add logo to nav
        self.setupNav()
        
        // Style Elements
        self.setupView()
        
        // Events
        actionbar.share.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShare)))
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
        
        let imageUrl = ApiRoutes.imageUrl(path: item.source)
    
        cell.setImage(url: imageUrl)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: view.safeAreaLayoutGuide.layoutFrame.height)
    }
}

