//: Playground - noun: a place where people can play

import UIKit

// Type is inferred
var str = "Hello, playground"

// Type is assigned explicitly
var myAge : Int = 41

// Simple operation
myAge + 10

// Constants (let) of different types
let myName : String        = "Jason"
let myFullName : String    = myName + " Clark"
let myDetails : String     = "Name: \(myFullName), Age: \(myAge)"
let wholeNumber : Int      = 99
let decimalFloat : Float   = 3.1459
let decimalDouble : Double = 33.333333

// Printing out the values
print(myName)
print(myFullName)
print(myDetails)
print(wholeNumber)
print(decimalFloat)
print(decimalDouble)


// Creating a function to print everything
func printEverything() {
    print("Printing Everything...\n")
    print(myName)
    print(myFullName)
    print(myDetails)
    print(wholeNumber)
    print(decimalFloat)
    print(decimalDouble)
}

printEverything()
