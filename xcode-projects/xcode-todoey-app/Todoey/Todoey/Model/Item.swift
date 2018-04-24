//
//  Item.swift
//  Todoey
//
//  Created by Jay Clark on 4/19/18.
//  Copyright © 2018 Jay Clark. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date? = nil         
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
