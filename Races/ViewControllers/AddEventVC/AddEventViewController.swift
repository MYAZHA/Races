//
//  FourthViewController.swift
//  Races
//
//  Created by Юрий Шелест on 15.05.22.
//

import UIKit
import MessageUI

class AddEventViewController: UIViewController {
    
    init() {
        super.init(nibName: "\(AddEventViewController.self)", bundle: nil)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    lazy var selectedCategory: String = ""
    let arrayCategory: [Category] = [Category(name: "Бег"),
                                     Category(name: "Триатлон"),
                                     Category(name: "Плавание"),
                                     Category(name: "Вело"),
                                     Category(name: "Лыжи"),
                                     Category(name: "Гонки с препятствиями") ]
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var linkTextField: UITextField!
    @IBOutlet private weak var buttonSendForm: UIButton!
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        
        let nib = UINib(nibName: "\(CategoryCollectionViewCell.self)", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "\(CategoryCollectionViewCell.self)")
        
        collectionView.backgroundColor = .clear
        buttonSendForm.setTitle("Отправить форму", for: .normal)
        buttonSendForm.setCornerRadius(5.0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction private func buttonSendFormDidTab() {
        let mailComposeViewController = configureMailComposer()
        
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            presentWarningAlert()
            print("Can't send email")
        }
    }
}


//MARK: -   UICollectionView
extension AddEventViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoryCollectionViewCell.self)", for: indexPath) as? CategoryCollectionViewCell
        cell?.setup(category: arrayCategory[indexPath.row])
        cell?.setAligmentCenter()
        cell?.setCornerRadius(5.0)
        cell?.setBorder(width: 0.5, color: .lightGray)
        return cell ?? .init()
    }
    
// Настройка отображения ячеек коллекции
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = CGFloat()
        let height = CGFloat((collectionView.bounds.height - 7.0 ) / 2)
        if indexPath.row <= 2 {
            width = (collectionView.bounds.width - 12.0) / 3
        } else if indexPath.row > 2 && indexPath.row < 5 {
            width = (collectionView.bounds.width - 12.0) / 4
        } else {
            width = (collectionView.bounds.width - 12.0) / 2
        }
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let allCells = collectionView.visibleCells as? [CategoryCollectionViewCell]
        allCells?.forEach{ cell in
            cell.unselectedCell()
        }
        let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell
        cell?.selectedCell()
        self.selectedCategory = arrayCategory[indexPath.row].name
    }
}

//MARK: - Mail
extension AddEventViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if result == .cancelled {
            controller.dismiss(animated: true, completion: nil)
        } else if result == .sent {
            controller.dismiss(animated: true, completion: nil)
            presentInfoAlert()
        } else {
            controller.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func configureMailComposer() -> MFMailComposeViewController{
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["y_shelest@mail.ru"])
        mailComposeVC.setSubject( "Добавить старт_\(nameTextField.text!) ")
        mailComposeVC.setMessageBody(
            "Описание старта: \(textView.text!)\n\nКатегория: \(selectedCategory)\n\nСсылка: \(linkTextField.text!)", isHTML: false)
        return mailComposeVC
    }
    
}
