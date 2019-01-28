//
//  Image.swift
//  Funny
//
//  Created by Robby Klein on 1/25/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class Image: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .scaleAspectFit
    }
    
    func rotate() {
        UIView.animate(withDuration: 1, delay: 0.0, options: .curveLinear, animations: {
            self.transform = self.transform.rotated(by: CGFloat(Float.pi))
        }) { finished in
            self.rotate()
        }
    }
    
    func fadeIn(duration: Double, delay: Double) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveLinear, animations: {
            self.alpha = 1
        })
    }
    
    func fadeOut(duration: Double, delay: Double) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveLinear, animations: {
            self.alpha = 0
        })
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
