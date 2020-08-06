//
//  RealmConfiguration.swift
//  TestSehatQ
//
//  Created by Raja on 08/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import UIKit
import RealmSwift

class RealmConfiguration {
    class func config() {
        guard let buildVersion = Bundle.main.infoDictionary! ["CFBundleVersion"] as? String else { return }
        let config = Realm.Configuration(
            schemaVersion: UInt64.init(CGFloat(Int(buildVersion) ?? 0)),
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {}
        })
        Realm.Configuration.defaultConfiguration = config
    }
    
    class func createObject(_ value: Object,_ realm: Realm) {
        try! realm.write {
            realm.add(value, update: true)
        }
    }
    
    class func deleteObject(_ object: Object, _ realm: Realm) {
        try! realm.write {
            realm.delete(object)
        }
    }
    
    class func getObject(_ object: Object.Type,_ realm: Realm) -> Object? {
        return realm.objects(object).first
    }
    
    class func getObjects(_ object: Object.Type,_ realm: Realm) -> Results<Object> {
        return realm.objects(object)
    }
}
