//
//  RealmService.swift
//  RealmLoadImage
//
//  Created by GraceToa on 20/05/2019.
//  Copyright © 2019 GraceToa. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    private init() {}
    static let shared = RealmService()
    
    var realm = try! Realm()
    
    func create<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch  {
            print(error)
        }
    }
    
    func update<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object, update: true)
            }
        } catch  {
            post(error)
        }
        
    }
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch  {
            post(error)
        }
    }
    
    func deleteAll() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch  {
            post(error)
        }
    }
    
    func post(_ error: Error)  {
        NotificationCenter.default.post(name: NSNotification.Name("RealmError"),object: error)
    }
    
    
}
