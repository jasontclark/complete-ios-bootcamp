//
//  SelfDrivingCar.swift
//  Classes and Objects
//
//  Created by Jay Clark on 2/16/18.
//  Copyright © 2018 Jay Clark. All rights reserved.
//

import Foundation

class SelfDrivingCar : Car {
    
    // Create destination as an optional
    var destination : String?
    
    override func drive() {
        super.drive()
        
        // Optional Binding to ensure
        // that destination is set
        if let userSetDestination = destination {
            print("driving towards " + userSetDestination)
        }
        
    }
}
