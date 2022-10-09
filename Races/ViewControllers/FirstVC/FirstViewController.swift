//
//  FirstViewController.swift
//  Races
//
//  Created by Юрий Шелест on 8.05.22.
//

import UIKit
import CoreData

class FirstViewController: UIViewController {
    
    init() {
        super.init(nibName: "\(FirstViewController.self)", bundle: nil)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    @IBOutlet private weak var categoryCollectionView: UICollectionView! {
        didSet {
            categoryCollectionView.dataSource = self
            categoryCollectionView.delegate = self
        }
    }
    @IBOutlet private weak var eventsCollectionView: UICollectionView! {
        didSet {
            eventsCollectionView.dataSource = self
            eventsCollectionView.delegate = self
        }
    }
    lazy var selectedCategory: String = "Популярные" {
        didSet {
            categoryCollectionView.reloadData()
            eventsCollectionView.reloadData()
        }
    }
    private let arrayCategory: [Category] = [Category(name: "Популярные"),
                                             Category(name: "Бесплатные"),
                                             Category(name: "На этой неделе"),
                                             Category(name: "В этом месяце") ]
    var popularEvents: [Event] = []
    var freeEvents: [Event] = []
    var thisWeekEvents: [Event] = []
    var thisMonthEvents: [Event] = []
    
    var arrayOfEvents: [Event] = [] {
        didSet {
            popularEvents = arrayOfEvents.filter { event in
                event.isPopular == true
            }.sorted(by: { event1, event2 in
                event1.date.timeIntervalSince1970 < event2.date.timeIntervalSince1970
            })
            freeEvents = arrayOfEvents.filter { event in
                event.isFree == true
            }.sorted(by: { event1, event2 in
                event1.date.timeIntervalSince1970 < event2.date.timeIntervalSince1970
            })
            thisWeekEvents = arrayOfEvents.filter { event in
                event.date.timeIntervalSince1970 > Date().timeIntervalSince1970 && event.date.timeIntervalSince1970 < (Date().timeIntervalSince1970 + (3600 * 24 * 7) )
            }.sorted(by: { event1, event2 in
                event1.date.timeIntervalSince1970 < event2.date.timeIntervalSince1970
            })
            thisMonthEvents = arrayOfEvents.filter { event in
                event.date.timeIntervalSince1970 > Date().timeIntervalSince1970 && event.date.timeIntervalSince1970 < (Date().timeIntervalSince1970 + (3600 * 24 * 30) )
            }.sorted(by: { event1, event2 in
                event1.date.timeIntervalSince1970 < event2.date.timeIntervalSince1970
            })
            
            self.eventsCollectionView.reloadData()
        }
    }
  


    var databaseService = DatabaseService()
 
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseService.loadEvents { events in
            self.arrayOfEvents = events
        }
        eventsCollectionView.backgroundColor = .clear
        
      
        
        let nibCategory = UINib(nibName: "\(CategoryCollectionViewCell.self)", bundle: nil)
        categoryCollectionView.register(nibCategory, forCellWithReuseIdentifier: "\(CategoryCollectionViewCell.self)")
        let nibEvent = UINib(nibName: "\(EventCollectionViewCell.self)", bundle: nil)
        eventsCollectionView.register(nibEvent, forCellWithReuseIdentifier: "\(EventCollectionViewCell.self)")
    }
    
    
    private func setupNavigationBar() {
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.tintColor = .black
        navigationItem.title = "Races"
        navigationBar?.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "DIN Condensed", size: 26.0)!,
            NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1)]
        let addBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                            style: .plain,
                                            target: self, action: #selector(addButtonDidTab) )
        
        navigationItem.leftBarButtonItem = addBarButton
    }
    
    @objc private func addButtonDidTab() {
         let nextVC = AddEventViewController()
         navigationController?.pushViewController(nextVC, animated: true)
    }
}

//MARK: -   UICollectionViewDelegate
extension FirstViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoryCollectionViewCell.self)", for: indexPath) as? CategoryCollectionViewCell
            cell?.setup(category: arrayCategory[indexPath.row])
            if arrayCategory[indexPath.row].name == selectedCategory {
                cell?.selectedCell()
            }
            return cell ?? .init()
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(EventCollectionViewCell.self)", for: indexPath) as? EventCollectionViewCell
            if selectedCategory == "Популярные" {
                cell?.setup(event: popularEvents[indexPath.row])
            } else if selectedCategory == "Бесплатные" {
                cell?.setup(event: freeEvents[indexPath.row])
            } else if selectedCategory == "На этой неделе" {
                cell?.setup(event: thisWeekEvents[indexPath.row])
            } else {
                cell?.setup(event: thisMonthEvents[indexPath.row])
            }
            
            return cell ?? .init()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.categoryCollectionView {
            return arrayCategory.count
        } else {
            if selectedCategory == "Популярные" {
                return popularEvents.count
            } else if selectedCategory == "Бесплатные" {
                return freeEvents.count
            } else if selectedCategory == "На этой неделе" {
                return thisWeekEvents.count
            } else {
                return thisMonthEvents.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.categoryCollectionView {
            return CGSize(width: UIScreen.main.bounds.width / 2.8,
                          height: categoryCollectionView.bounds.height)
        } else {
            return CGSize(width: UIScreen.main.bounds.width - 100,
                          height: eventsCollectionView.bounds.height)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.eventsCollectionView {
            
            var bufferArray: [Event] = []
            if selectedCategory == "Популярные" {
                bufferArray =  popularEvents
            } else if selectedCategory == "Бесплатные" {
                bufferArray = freeEvents
            } else if selectedCategory == "На этой неделе" {
                bufferArray =  thisWeekEvents
            } else {
                bufferArray =  thisMonthEvents
            }
            let nextVC = EventViewController(event: bufferArray[indexPath.row])
            navigationController?.pushViewController(nextVC, animated: true)
        } else {
            selectedCategory = arrayCategory[indexPath.row].name
        }
        
    }
}


