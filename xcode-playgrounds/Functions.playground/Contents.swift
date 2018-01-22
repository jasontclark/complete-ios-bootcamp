//: Playground - noun: a place where people can play

// Create the getMilk() function
//func getMilk() {
//    print("Go to the shops")
//    print("Buy 2 cartons of milk")
//    print("Pay 4 dollars")
//    print("Come Home")
//}

// Passing the howManyMilkCartons arg into the function
//func getMilk(howManyMilkCartons : Int) {
//    print("Go to the shops")
//    print("Buy \(howManyMilkCartons) cartons of milk")
//
//    // Calculating the total price to pay
//    let priceToPay = howManyMilkCartons * 4
//
//    print("Pay $\(priceToPay)")
//    print("Come Home")
//}


// Passing both the number of cartons to buy and the amount of money the robot was given
func getMilk(howManyMilkCartons : Int, howMuchMoneyRobotWasGiven: Int) -> Int {
    print("Go to the shops")
    print("Buy \(howManyMilkCartons) cartons of milk")

    // Calculate the total price to pay
    let priceToPay = howManyMilkCartons * 4
    
    // Calculate the amount of change
    let change = howMuchMoneyRobotWasGiven - priceToPay

    print("Pay $\(priceToPay)")
    print("Come Home")
    
    return change
}


// Calling a function with a parameter
var amountOfChange = getMilk(howManyMilkCartons: 4, howMuchMoneyRobotWasGiven: 20)

print("Hello master, here's your $\(amountOfChange) change.")

