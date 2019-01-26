//
//  ItemCell.swift
//  Funny
//
//  Created by Robby Klein on 1/24/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell, UIScrollViewDelegate {
    // Scroll View for overflow images
    let scroll = ItemScroll()
    
    // Elements
    let imageView = Image()
    let loading = Image()

    // Image height constraint
    var imageHeight:NSLayoutConstraint?
    var imageTop:NSLayoutConstraint?
    var imageCenter:NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor.App.background
        
        // Add elements to cell
        self.addSubview(scroll)

        scroll.addSubview(loading)
        scroll.addSubview(imageView)
        
        // Style elements
        scroll.setSize(parent: self)

        loading.image = UIImage(named: "loading")
        loading.centerXAnchor.constraint(equalTo: scroll.centerXAnchor).isActive = true
        loading.centerYAnchor.constraint(equalTo: scroll.centerYAnchor).isActive = true
        loading.setSize(width: 64, height: 64)
        loading.rotate()
        
        imageView.alpha = 0
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: scroll.leftAnchor).isActive = true
        
        // Active constraint depends on image height
        imageTop = imageView.topAnchor.constraint(equalTo: scroll.topAnchor)
        imageCenter = self.imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -20)
        
        self.imageHeight = self.imageView.heightAnchor.constraint(equalToConstant: 100)
        self.imageHeight?.isActive = true
    }
    
    func setImage(url: String) {        
        if let image = ImageCache.shared.image(forKey: url) {
            // Found in cache, set it
            placeImage(image: image)
        
        } else {
            Networking.shared.fetchImageData(url: url) { (data, error) in
                // If theres an error show fallback image
                if let error = error?.localizedDescription {
                    let named = error == "404 Not Found" ? "image_404" : "image_failed"
                
                    if let image = UIImage(named: named) {
                        self.placeImage(image: image)
                    }

                    return
                }
                
                // Otherwise show the actual image
                if let data = data {
                    if let image = UIImage(data: data) {
                        // Cache it for reuse
                        ImageCache.shared.save(image: image, forKey: url)
                        
                        // Set it
                        self.placeImage(image: image)
                    }
                }
            }
        }
    }
    
    func placeImage(image: UIImage) {
        DispatchQueue.main.async() {
            // Calculate scaled height
            let viewWidth = self.scroll.frame.width
            let viewHeight = self.scroll.frame.height
            let height = image.size.height
            let width = image.size.width
            let imageScale = viewWidth / width
            let scaledHeight = height * imageScale
            
            // Set scrollview content height
            self.scroll.contentSize = CGSize(width: viewWidth, height: scaledHeight)
            
            // Set Image Height
            self.imageHeight?.constant = scaledHeight
            
            // Center image?
            if (viewHeight > scaledHeight) {
                self.imageTop?.isActive = false
                self.imageCenter?.isActive = true
            } else {
                self.imageTop?.isActive = true
                self.imageCenter?.isActive = false
            }
            
            // Set image
            self.imageView.image = image
            self.imageView.fadeIn(duration: 0.2, delay: 0.2)
        }
    }

    override func prepareForReuse() {
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
