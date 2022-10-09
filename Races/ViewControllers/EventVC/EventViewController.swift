//
//  EventViewController.swift
//  Races
//
//  Created by Юрий Шелест on 3.08.22.
//

import UIKit

class EventViewController: UIViewController {
  
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var categoreLabel: UILabel!
    @IBOutlet private weak var isFreeLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var descriptionTextView: UITextView!
    
    private var event: Event
    
    init(event: Event) {
        self.event = event
        super.init(nibName: "\(Self.self)", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("\(Self.self) was called by coder")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.tintColor = .black
        navigationItem.title = event.name
        navigationBar?.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "DIN Condensed", size: 26.0)!,
            NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1)]
        let backBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                            style: .plain,
                                            target: self, action: #selector(backButtonDidTab) )
        navigationItem.leftBarButtonItem = backBarButton
    }
    
    @objc private func backButtonDidTab() {
         navigationController?.popViewController(animated: true)
    }

    private func setupVC() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.string(from: event.date)
        
        dateLabel.text = date
        categoreLabel.text = event.category
        descriptionTextView.text = event.description
        imageView.image = event.image
        if event.isFree {
            isFreeLabel.text = "Да"
        } else {
            isFreeLabel.text = "Нет"
        }
    }

}
