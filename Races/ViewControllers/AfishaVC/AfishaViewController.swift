//
//  AfishaViewController.swift
//  Races
//
//  Created by Юрий Шелест on 23.07.22.
//

import UIKit

class AfishaViewController: UIViewController {

    init() {
        super.init(nibName: "\(Self.self)", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    var databaseService = DatabaseService()
    var sortedArray: [Event] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var arrayOfEvents: [Event] = [] {
        didSet {
            sortedArray = arrayOfEvents.sorted(by: { event1, event2 in
                event1.date.timeIntervalSince1970 < event2.date.timeIntervalSince1970
            })
//            tableView.reloadData()
        }
    }
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = 180.0
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseService.loadEvents { events in
            self.arrayOfEvents = events
        }
       
        
        let nibEvent = UINib(nibName: "\(AfishaTableViewCell.self)", bundle: nil)
        tableView.register(nibEvent, forCellReuseIdentifier: "\(AfishaTableViewCell.self)")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.tintColor = .black
        navigationItem.title = "Афиша"
        navigationBar?.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "DIN Condensed", size: 26.0)!,
            NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1)]
        
    }
    

  

}
extension AfishaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(AfishaTableViewCell.self)", for: indexPath) as? AfishaTableViewCell
        cell?.setup(event: sortedArray[indexPath.row])
        return cell ?? .init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let nextVC = EventViewController(event: sortedArray[indexPath.row])
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
