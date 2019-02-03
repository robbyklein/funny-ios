//
//  ItemCell.swift
//  Funny
//
//  Created by Robby Klein on 1/24/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell, UIScrollViewDelegate {
    // Elements
    let scroll = ItemScroll()
    let imageView = Image()
    let loading = Image()

    // Constraints that get changed dependent on image size
    var imageHeight:NSLayoutConstraint?
    var imageTop:NSLayoutConstraint?
    var imageCenter:NSLayoutConstraint?
    
    override init(frame: CGRect) {
        // Init a collection view cell
        super.init(frame: .zero)
        
        // Set up the view
        setupView()
    }
    
    func setupView() {
        // Set the background color
        self.backgroundColor = UIColor.App.background
        
        // Add elements to cell
        self.addSubview(scroll)
        scroll.addSubview(loading)
        scroll.addSubview(imageView)
        
        // Style elements
        scroll.fullCoverage(parent: self, heightConstant: -50, widthConstant: 0)
        loading.image = UIImage(named: "loading")
        loading.centerCenter(parent: scroll)
        loading.setSize(widthConstant: 64, heightConstant: 64)
        loading.rotate()
        imageView.alpha = 0
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: scroll.leftAnchor).isActive = true
        
        // Set default constraints
        imageTop = imageView.topAnchor.constraint(equalTo: scroll.topAnchor)
        imageCenter = self.imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -20)
        imageHeight = self.imageView.heightAnchor.constraint(equalToConstant: 100)
        
        // Constant will change but this is always active
        self.imageHeight?.isActive = true
    }
    
    // Set the cells image
    func setImage(url: String) {
        // Check if it's in the cache first
        if let image = ImageCache.shared.image(forKey: url) {
            // Position with cached image
            placeImage(image: image)
        
        } else {
            // Otherwise fetch it from the source url
            Networking.shared.fetchImageData(url: url) { (data, error) in
                // If theres an error show fallback image
                if let error = error?.localizedDescription {
                    // Is it not found or a download error?
                    let named = error == "404 Not Found" ? "image_404" : "image_failed"
                    
                    // Show appropriate image
                    if let image = UIImage(named: named) {
                        // Place stored image
                        self.placeImage(image: image)
                    }

                    // Return early skipping below
                    return
                }
                
                // Otherwise show the actual image
                if let data = data {
                    // Create UIImage from data
                    if let image = UIImage(data: data) {
                        // Cache it for re-use
                        ImageCache.shared.save(image: image, forKey: url)
                        
                        // Place the downloaded image
                        self.placeImage(image: image)
                    }
                }
            }
        }
    }
    
    // Load image from core data on Favorites
    func loadImage(data: Data) {
        // Create UIImage from data
        if let image = UIImage(data: data) {
            // Place the image
            self.placeImage(image: image)
        }
    }
    
    func placeImage(image: UIImage) {
        // Required to be on main thread
        DispatchQueue.main.async() {
            // Calculate scaled height (when width is 100% of view)
            let viewWidth = self.scroll.frame.width // View width
            let viewHeight = self.scroll.frame.height // View height
            let height = image.size.height // Image height
            let width = image.size.width // Image width
            let imageScale = viewWidth / width // Whats the scale
            let scaledHeight = height * imageScale // Whats the height at scale
            
            // Set ScrollBiew content height
            self.scroll.contentSize = CGSize(width: viewWidth, height: scaledHeight)
            
            // Set Image Height
            self.imageHeight?.constant = scaledHeight
            
            // Center the image if smaller than view height
            if (viewHeight > scaledHeight) {
                self.imageTop?.isActive = false
                self.imageCenter?.isActive = true
            }
            // Otherwise align to top
            else {
                self.imageTop?.isActive = true
                self.imageCenter?.isActive = false
            }
            
            // Set the actual image
            self.imageView.image = image
            
            // And fade it in
            self.imageView.fadeIn(duration: 0.2, delay: 0.2)
        }
    }

    override func prepareForReuse() {
        // Reset image for reuse
        self.loading.alpha = 1
        self.imageView.alpha = 0
        self.imageView.image = nil
        self.imageTop?.isActive = false
        self.imageCenter?.isActive = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
