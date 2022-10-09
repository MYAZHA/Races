//
//  TabBarViewController.swift
//  Races
//
//  Created by Юрий Шелест on 23.07.22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
    }
    //
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(
                viewController: FirstViewController(),
                title: "Главная",
                image: UIImage(systemName: "house")),
            generateVC(
                viewController: AfishaViewController(),
                title: "Афиша",
                image: UIImage(systemName: "calendar")) ]
    }
    
    private func generateVC (viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return UINavigationController(rootViewController: viewController)
    }
    
    private func setTabBarAppearance() {
        let positionX: CGFloat = 5
        let positionY: CGFloat = 14
        let width = tabBar.bounds.width - positionX * 2
        let height = tabBar.bounds.height + positionY * 2
        
        let roundLayer = CAShapeLayer()
        
        let befierPath = UIBezierPath(
            roundedRect: CGRect(
                x: positionX,
                y: tabBar.bounds.minX - positionY,
                width: width,
                height: height),
            cornerRadius: height / 2
        )
        roundLayer.path = befierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 2
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.tabBarView.cgColor
        tabBar.tintColor = UIColor.tabBarItemAccent
        tabBar.unselectedItemTintColor = UIColor.tabBarItemLight
    }
}
