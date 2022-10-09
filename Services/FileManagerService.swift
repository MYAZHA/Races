//
//  FileManagerService.swift
//  Races
//
//  Created by Юрий Шелест on 4.08.22.
//

import Foundation
import UIKit
final class FileManagerService {
    
    private var localName: String {
        get {
            return UserDefaults.standard.string(forKey: "localName") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "localName")
        }
    }
    
    func saveImage(eventID: Int, image: UIImage) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            let data = image.jpegData(compressionQuality: 1.0)
            
            var directoryPath = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
           
            let localName = "picture-\(eventID).jpeg"
            self?.localName = localName
            
            directoryPath?.appendPathComponent(localName)
            
            if let filePath = directoryPath {
                try? data?.write(to: filePath)
            }
        }
    }
    
    func loadImage(complition: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            var directoryPath = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            directoryPath?.appendPathComponent(self?.localName ?? "")
            
            if let filePath = directoryPath, let data = try? Data(contentsOf: filePath) {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                   complition(image)
                }
            }
        }
    }
}

// Пробное изменение

