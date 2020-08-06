//
//  DetailProductViewModel.swift
//  TestSehatQ
//
//  Created by Raja on 09/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import UIKit

protocol DetailProductInput {
    var product: Product { get set }
}

class DetailProductViewModel: DetailProductInput {
    var product: Product
    
    init(_ product: Product) {
        self.product = product
    }
}
