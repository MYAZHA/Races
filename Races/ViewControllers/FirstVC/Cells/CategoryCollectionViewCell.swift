//
//  CategoryCollectionViewCell.swift
//  Races
//
//  Created by Юрий Шелест on 13.06.22.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    
    func setup(category: Category) {
        nameLabel.text = category.name
        nameLabel.textColor = .gray
    }
    
    func selectedCell() {
        nameLabel.textColor = .black
    }
    func unselectedCell() {
        nameLabel.textColor = .gray
    }
    
    func setAligmentCenter () {
        nameLabel.textAlignment = .center
    }
}
