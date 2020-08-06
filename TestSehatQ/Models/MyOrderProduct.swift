//
//  MyOrderProduct.swift
//  TestSehatQ
//
//  Created by Raja on 09/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class MyOrderProduct: Object, Mappable {
    @objc dynamic var id = 1
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
    
    func incrementID() -> Int{
        let realm = try! Realm()
        let RetNext: NSArray = Array(realm.objects(MyOrderProduct.self).sorted(byKeyPath: "id")) as NSArray
        let last = RetNext.lastObject
        if RetNext.count > 0 {
            let valor = (last as AnyObject).value(forKey: "id") as? Int
            return valor! + 1
        } else {
            return 1
        }
    }
    
    class func create(object: MyOrderProduct) {
        let realm = try! Realm()
        try! realm.write {
            realm.create(MyOrderProduct.self, value: object, update: true)
        }
    }
    
    class func all() -> [MyOrderProduct] {
        let realm = try! Realm()
        let objects = realm.objects(MyOrderProduct.self)
        var orderProducts = [MyOrderProduct]()
        objects.forEach { (object) in
            orderProducts.append(object)
        }
        return orderProducts
    }
    
    class func delete(object: MyOrderProduct) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(object)
        }
    }
}
