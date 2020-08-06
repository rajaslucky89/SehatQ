//
//  UIViewController.swift
//  TestSehatQ
//
//  Created by Raja on 08/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//
import UIKit

extension UIViewController {
    func showLoader(_ style: UIActivityIndicatorView.Style) {
        Spinner.start(style: style)
    }
    
    func hideLoader() {
        Spinner.stop()
    }
    
    func redirectTo(_ viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showModal(_ viewController: UIViewController) {
        self.navigationController?.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(viewController, animated: true, completion: nil)
    }
    
    func redirectToRoot() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func presentShareMessage(message: String){
        let activityViewController = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view // so that iPads won't crash
        present(activityViewController, animated: true, completion: nil)
    }
}
