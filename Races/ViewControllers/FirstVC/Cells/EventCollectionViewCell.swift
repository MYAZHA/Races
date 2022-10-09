//
//  EventCollectionViewCell.swift
//  Races
//
//  Created by Юрий Шелест on 9.07.22.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var categoreLabel: UILabel!
    @IBOutlet private weak var mainImage: UIImageView!
    
    
    
    func setup(event: Event) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.string(from: event.date)
        
        nameLabel.text = event.name
        dateLabel.text = date
        categoreLabel.text = event.category
        mainImage.image = event.image
        mainImage.contentMode = .scaleAspectFill
    }

   
    
    
}
