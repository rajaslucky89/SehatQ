//
//  Category.swift
//  TestSehatQ
//
//  Created by Raja on 08/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import UIKit
import ObjectMapper

class Category: Mappable {
    var id: Int = 0
    var imageUrl: String = ""
    var name: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        imageUrl <- map["imageUrl"]
        name <- map["name"]
    }
}
