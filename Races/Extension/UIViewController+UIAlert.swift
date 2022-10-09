//
//  UIViewController+UIAlert.swift
//  Races
//
//  Created by Юрий Шелест on 2.08.22.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentInfoAlert() {
        let infoAlert = UIAlertController(
            title: "Спасибо!",
            message: "Форма отправлена и будет обработана в ближайшее время",
            preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) { action in
            infoAlert.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
        infoAlert.addAction(okButton)
        present(infoAlert, animated: true, completion: nil)
    }
    
    
    func presentWarningAlert() {
        let warningAlert = UIAlertController(
            title: "Предупреждение!",
            message: "Для отправки письма необходимо установленное приложение Почта, а также подключение к iCloud",
            preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) { action in
            warningAlert.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
        warningAlert.addAction(okButton)
        present(warningAlert, animated: true, completion: nil)
    }
}
