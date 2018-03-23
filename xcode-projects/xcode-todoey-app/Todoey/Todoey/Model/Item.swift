//
//  Item.swift
//  Todoey
//
//  Created by Jay Clark on 3/19/18.
//  Copyright © 2018 Jay Clark. All rights reserved.
//

import Foundation


// In order for a class to be Encodable
// all of its properties must have
// standard data types
class Item : Encodable {
    var title : String = ""
    var done : Bool = false
}
