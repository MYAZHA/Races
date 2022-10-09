//
//  FivthViewController.swift
//  Races
//
//  Created by Юрий Шелест on 13.06.22.
//

import UIKit

class EventsViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!

    let arrayOfEvents: [Event] = [
        Event(name: "Сожский полумарафон", image: UIImage(named: "race_1"), category: Category(name: "Бег"), date: "01.08.2022", description: nil),
        Event(name: "Минская велогонка", image: UIImage(named: "race_2"), category: Category(name: "Вело"), date: "20.08.2022", description: nil),
        Event(name: "Минский ультрамарафон", image: UIImage(named: "race_3"), category: Category(name: "Бег"), date: "04.09.2022", description: nil),
        Event(name: "Volatman", image: UIImage(named: "race_4"), category: Category(name: "Триатлон"), date: "10.07.2022", description: nil),
        Event(name: "Bison race", image: UIImage(named: "race_5"), category: Category(name: "Гонка с препятствиями"), date: "21.09.2022", description: nil),
        Event(name: "Минский триатлон", image: UIImage(named: "race_6"), category: Category(name: "Триатлон"), date: "31.07.2022", description: nil),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }
    

}


extension EventsViewController: UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return arrayOfEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(EventTableViewCell.self)", for: indexPath) as? EventTableViewCell
            cell?.setup(event: arrayOfEvents[indexPath.row])
        return cell ?? .init()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return EventTableViewCell.rowHeight
    }
    
}
