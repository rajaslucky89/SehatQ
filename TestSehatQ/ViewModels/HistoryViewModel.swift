//
//  HistoryViewModel.swift
//  TestSehatQ
//
//  Created by Raja on 09/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import UIKit

class HistoryViewModel {
    var items = [MyOrderProduct]()
    
    func getData() {
        self.items = MyOrderProduct.all()
    }
}
