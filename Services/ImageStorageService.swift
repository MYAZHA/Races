//
//  ImageStorageService.swift
//  Races
//
//  Created by Юрий Шелест on 30.07.22.
//
import UIKit
import Foundation
import FirebaseStorage

final class ImageStorageService {
    
let storageRef = Storage.storage().reference()
    
    func loadImage(link: String, complition: @escaping (UIImage?) -> Void) {
        let imageRef = self.storageRef.child(link)
        var image: UIImage?
        imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Load image faled - error: \(error)")
            } else {
                image = UIImage(data: data!)
                print("Изображение загрузилось \(image)")
                DispatchQueue.main.async {
                    complition(image)
                }
            }
        }
    }
    
}
