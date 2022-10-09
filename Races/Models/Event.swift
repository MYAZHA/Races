//
//  Event.swift
//  Races
//
//  Created by Юрий Шелест on 13.06.22.
//

import Foundation
import UIKit

struct Event {
    var id: Int
    var name: String
    var date: Date
    var image: UIImage?
    var category: String
    var description: String
    var isPopular: Bool
    var isFree: Bool
    var isFavorite: Bool
}

struct Category {
    var name: String
}


