//
//  APIData.swift
//  TestSehatQ
//
//  Created by Raja on 08/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import UIKit
import ObjectMapper
import ObjectMapperAdditions

class NetworkData: Mappable {
    var data: APIData?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        data <- map["data"]
    }
}

class APIData: Mappable {
    var category: [Category]?
    var promos: [Product]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        category <- map["category"]
        promos <- map["productPromo"]
    }
}
