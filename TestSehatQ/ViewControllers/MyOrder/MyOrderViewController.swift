//
//  MyOrderViewController.swift
//  TestSehatQ
//
//  Created by Raja on 08/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import UIKit

class MyOrderViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setComponents()
        
    }
}

extension MyOrderViewController {
    private func setComponents() {
        title = Attribute.myOrder
    }
}
