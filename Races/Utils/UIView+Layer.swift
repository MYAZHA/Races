//
//  UIView+Layer.swift
//  Races
//
//  Created by Юрий Шелест on 15.05.22.
//

import UIKit

extension UIView {
    func setCornerRadius(_ radius: CGFloat){
        self.layer.cornerRadius = radius
    }
    func setBorder(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        
    }
    
    
    
}
