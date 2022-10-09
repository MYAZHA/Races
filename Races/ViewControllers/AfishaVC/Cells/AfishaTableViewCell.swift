//
//  AfishaTableViewCell.swift
//  Races
//
//  Created by Юрий Шелест on 4.08.22.
//

import UIKit

class AfishaTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var isFreeLabel: UILabel!
    @IBOutlet private weak var mainImage: UIImageView!

    
    
    func setup(event: Event) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.string(from: event.date)
        
        nameLabel.text = event.name
        dateLabel.text = date
        categoryLabel.text = event.category
        mainImage.image = event.image
        mainImage.contentMode = .scaleAspectFill
        if event.isFree {
            isFreeLabel.text = "Да"
        } else {
            isFreeLabel.text = "Нет"
        }
    }
    
}
