//
//  ImageCache.swift
//  Funny
//
//  Created by Robby Klein on 1/24/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class ImageCache {
    // Cache instance
    private let cache = NSCache<NSString, UIImage>()
    
    // Observer
    private var observer: NSObjectProtocol!
    
    // Singleton instance
    static let shared = ImageCache()
    
    // Make outside initiation impossible
    private init() {
        // Listen for full cache
        observer = NotificationCenter.default.addObserver(forName: UIApplication.didReceiveMemoryWarningNotification, object: nil, queue: nil) { [weak self] notification in
            // Empty when full
            self?.cache.removeAllObjects()
        }
    }
    
    deinit {
        // Remove observer on deinit
        NotificationCenter.default.removeObserver(observer)
    }
    
    // Find/return in cache
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    // Cache image
    func save(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
