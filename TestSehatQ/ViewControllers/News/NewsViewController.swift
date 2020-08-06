//
//  NewsViewController.swift
//  TestSehatQ
//
//  Created by Raja on 08/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setComponents()
    }
    
}

extension NewsViewController {
    private func setComponents() {
        title = Attribute.news
    }
}
