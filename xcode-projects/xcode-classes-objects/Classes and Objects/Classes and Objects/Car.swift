//
//  Car.swift
//  Classes and Objects
//
//  Created by Jay Clark on 2/16/18.
//  Copyright © 2018 Jay Clark. All rights reserved.
//

import Foundation

enum CarType {
    case Sedan
    case Coupe
    case Hatchback
}

class Car {
    
    var color         = "Black"
    var numberOfSeats = 5
    
    // Use the dot notation to access the enum cases
    var typeOfCar : CarType = .Coupe
    
//    init(customCarColor : String, customNumOfSeats : Int, customCarType : CarType) {
//        color = customCarColor
//        numberOfSeats = customNumOfSeats
//        typeOfCar = customCarType
//    }
    
    // Default initializer
    init() {

    }
    
    // Convenience initialzer to "override" the default
    convenience init(customCarColor : String) {
        
        // Calls the default initializer
        self.init()
        color = customCarColor
    }
    
    func drive() {
        print("Car is moving")
    }
}
