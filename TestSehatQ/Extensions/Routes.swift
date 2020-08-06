//
//  Routes.swift
//  TestSehatQ
//
//  Created by Raja on 08/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import UIKit

class Routes: NSObject {
    private var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func setAppRootViewController(with viewController: UIViewController) {
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
        navigationController.setDefault()
        navigationController.popToRootViewController(animated: false)
    }
}
