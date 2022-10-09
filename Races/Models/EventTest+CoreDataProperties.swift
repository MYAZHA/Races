//
//  EventTest+CoreDataProperties.swift
//  Races
//
//  Created by Юрий Шелест on 4.08.22.
//
//

import Foundation
import CoreData


extension EventTest {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventTest> {
        return NSFetchRequest<EventTest>(entityName: "EventTest")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var date: Date?
    @NSManaged public var descriptionEvent: String?
    @NSManaged public var category: String?
    @NSManaged public var isPopular: Bool
    @NSManaged public var isFree: Bool
    @NSManaged public var isFavorite: Bool
    @NSManaged public var imageLink: String?

}

extension EventTest : Identifiable {

}
