//
//  MasterTabBar.swift
//  TestSehatQ
//
//  Created by Raja on 08/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import UIKit

class MasterTabBar: UITabBarController, UITabBarControllerDelegate  {
    static var selectedIndexTabar = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mockUpDidLoad()
        setUpTabBar()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.selectedIndex = MasterTabBar.selectedIndexTabar
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return (viewController != tabBarController.selectedViewController)
    }
}

// MARK: - Mock Up
extension MasterTabBar {
    func mockUpDidLoad() {
        navigationController?.isNavigationBarHidden = true
        tabBar.barTintColor = UIColor.white
        tabBar.backgroundColor = UIColor.white
        tabBar.tintColor = .greenSehatQ
        tabBar.layer.shadowOpacity = 0.3
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -0.9)
        tabBar.layer.shadowColor = UIColor.gray.cgColor
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
    }
    
    func setUpTabBar() {
        let v1 = HomeViewController()
        let v2 = NewsViewController()
        let v3 = MyOrderViewController()
        let v4 = PromotionViewController()
        let v5 = ProfileViewController()
        
        v1.tabBarItem = UITabBarItem(title: "Home", image: ImageName.iconHome, tag: 0)
        v2.tabBarItem = UITabBarItem(title: "News", image: ImageName.iconNews, tag: 1)
        v3.tabBarItem = UITabBarItem(title: "My Order", image: ImageName.iconOrder, tag: 2)
        v4.tabBarItem = UITabBarItem(title: "Promotion", image: ImageName.iconPromo, tag: 3)
        v5.tabBarItem = UITabBarItem(title: "Profile", image: ImageName.iconProfile, tag: 4)
        let viewControllerList = [v1, v2, v3, v4, v5]
        viewControllers = viewControllerList.map { UINavigationController(rootViewController: $0) }
    }
}

