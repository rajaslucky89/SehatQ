//
//  UINavigationController.swift
//  TestSehatQ
//
//  Created by Raja on 08/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import UIKit

extension UINavigationController {
    func setDefault() {
        self.navigationBar.barStyle = .black
        self.navigationBar.barTintColor = .greenSehatQ
        self.navigationBar.tintColor = .white
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = false
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13.0)]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: UIControl.State.highlighted)
        
//        guard let coordinator = self.transitionCoordinator else {
//            return
//        }
//        coordinator.animate(alongsideTransition: { [weak self] context in self?.whiteStyle() }, completion: nil)
    }

    func whiteStyle() {
        self.navigationBar.barTintColor = .white
        self.navigationBar.barStyle = .default
        self.navigationBar.isTranslucent = false
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13.0)]
        self.navigationBar.items?.last?.backBarButtonItem?.title = nil
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: UIControl.State.highlighted)
        
//        guard let coordinator = self.transitionCoordinator else {
//            return
//        }
//        coordinator.animate(alongsideTransition: { [weak self] context in self?.setDefault() }, completion: nil)
    }

}
