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
    let scroll = Scroll()
    
    // The image
    let imageView = UIImageView()
    
    // Image height constraint
    var imageHeight:NSLayoutConstraint?
    var imageTop:NSLayoutConstraint?
    var imageCenter:NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        // Add elements to cell
        self.addSubview(scroll)
        scroll.addSubview(imageView)
        
        // Style elements
        scroll.fullCoverage(parent: self)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: scroll.leftAnchor).isActive = true
        imageView.contentMode = .scaleAspectFit
        
        // Active constraint depends on image height
        imageTop = imageView.topAnchor.constraint(equalTo: scroll.topAnchor)
        imageCenter = self.imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        
        self.imageHeight = self.imageView.heightAnchor.constraint(equalToConstant: 100)
        self.imageHeight?.isActive = true
    }
    
    func setImage(url: String) {
        if let image = ImageCache.shared.image(forKey: url) {
            // Found in cache, set it
            placeImage(image: image)
        } else {
            Networking.shared.fetchImageData(url: url) { (data) in
                if let image = UIImage(data: data) {
                    // Cache it for reuse
                    ImageCache.shared.save(image: image, forKey: url)
                    
                    // Set it
                    self.placeImage(image: image)
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
        }
    }

    override func prepareForReuse() {
        self.imageView.image = nil
        self.imageTop?.isActive = false
        self.imageCenter?.isActive = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
