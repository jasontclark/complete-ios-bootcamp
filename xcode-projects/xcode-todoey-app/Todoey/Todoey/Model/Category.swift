//
//  Category.swift
//  Todoey
//
//  Created by Jay Clark on 4/19/18.
//  Copyright © 2018 Jay Clark. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
