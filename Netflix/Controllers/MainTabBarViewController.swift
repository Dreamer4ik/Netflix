//
//  MainTabBarViewController.swift
//  Netflix
//
//  Created by Ivan Potapenko on 18.07.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPurple
        configure()
    }
    
    
    private func configure() {
        let vc1 = HomeViewController()
        let vc2 = UpcomingViewController()
        let vc3 = SearchViewController()
        let vc4 = DownloadsViewController()
        
        vc1.title = "Home"
        vc2.title = "Notifications"
        vc3.title = "Profile"
        vc4.title = "Profile"
        
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)
        
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Coming Soon", image: UIImage(systemName: "play.circle"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Top Search", image: UIImage(systemName: "magnifyingglass"), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Downloads", image: UIImage(systemName: "arrow.down.to.line"), tag: 4)
        
        tabBar.tintColor = .label
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: false)
    }
}

