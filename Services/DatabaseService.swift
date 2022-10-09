//
//  DatabaseService.swift
//  Races
//
//  Created by Юрий Шелест on 1.08.22.
//

import Foundation
import FirebaseCore
import FirebaseDatabase
import CoreData

final class DatabaseService {

var ref: DatabaseReference! = Database.database().reference()
var imageStorageService = ImageStorageService()

    
    func loadEvents (complition: @escaping ([Event]) -> Void)  {
        self.ref.child("events").observe(.value) { [self] snapshot in
            var arrayOfEvents: [Event] = []
            if let observeSnapShot = snapshot.children.allObjects as? [DataSnapshot] {
                print(observeSnapShot)
                for observeSnap in observeSnapShot {
                    guard let testValue = observeSnap.value as? [String : Any] else { return }
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd.MM.yyyy"
                    let date = dateFormatter.date(from: testValue["date"] as! String)
                    
                    var buferObject = Event(
                        id: testValue["id"] as! Int,
                        name: testValue["name"] as! String,
                        date: date ?? Date(),
                        image: nil,
                        category: testValue["category"] as! String,
                        description: testValue["description"] as! String,
                        isPopular: testValue["isPopular"] as! Bool,
                        isFree: testValue["isFree"] as! Bool,
                        isFavorite: testValue["isFavorite"] as! Bool )
                    
                    self.imageStorageService.loadImage(link: testValue["imageLink"] as! String) { image in
                        buferObject.image = image
                        arrayOfEvents.append(buferObject)
                        complition(arrayOfEvents)
                        
                        
                    }
                }
            }
        }
    }
    
}


