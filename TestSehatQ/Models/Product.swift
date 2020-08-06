//
//  Product.swift
//  TestSehatQ
//
//  Created by Raja on 08/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Product: Object, Mappable {
    @objc dynamic var id: String = ""
    @objc dynamic var imageUrl: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var price: String = ""
    @objc dynamic var loved: Int = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        imageUrl <- map["imageUrl"]
        title <- map["title"]
        desc <- map["description"]
        price <- map["price"]
        loved <- map["loved"]
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    class func create(object: Product) {
        let realm = try! Realm()
        try! realm.write {
            realm.create(Product.self, value: object, update: true)
        }
    }
    
    class func all() -> [Product] {
        let realm = try! Realm()
        let objects = realm.objects(Product.self)
        var products = [Product]()
        objects.forEach { (object) in
            products.append(object)
        }
        return products
    }
    
    class func delete(object: Product) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(object)
        }
    }
}
