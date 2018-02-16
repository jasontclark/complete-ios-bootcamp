//
//  main.swift
//  Classes and Objects
//
//  Created by Jay Clark on 2/16/18.
//  Copyright © 2018 Jay Clark. All rights reserved.
//

import Foundation

let myCar = Car()
let mySelfDrivingCar = SelfDrivingCar()

let someRichGuysCar = Car(customCarColor: "Gold")

myCar.drive()

mySelfDrivingCar.drive()
print(mySelfDrivingCar.color)

