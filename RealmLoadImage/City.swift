//
//  City.swift
//  RealmLoadImage
//
//  Created by GraceToa on 19/05/2019.
//  Copyright © 2019 GraceToa. All rights reserved.
//

import Foundation
import RealmSwift

class City: Object {
    
    @objc dynamic var title = ""
    @objc dynamic var subtitle = ""
    @objc dynamic var image: Data? = nil
    @objc dynamic var id = UUID().uuidString
    
    //para obligar que el id sea un string
    override static func primaryKey() -> String? {
        return "id"
    }
}



