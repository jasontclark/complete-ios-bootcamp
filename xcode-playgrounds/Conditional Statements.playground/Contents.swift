//: Playground - noun: a place where people can play

import UIKit

func loveCalculator(yourName : String, theirName : String) -> String {
    // Generate a Random Number between 0 and 100
    let loveScore = arc4random_uniform(101)
    
    // Return the score and the "chance at love"
    if loveScore > 80 {
        return "Your love score is \(loveScore). You love each other like Kanye loves Kanye."
    }
    else if loveScore > 40 && loveScore <= 80 {
        return "Your love score is \(loveScore). You go together like Coke and Mentos."
    }
    else {
        return "Your love score is \(loveScore). You'll be forever alone."
    }
    
}

// Print the output of the loveCalculator() function
print(loveCalculator(yourName: "Nasir Jones", theirName: "Nicki Minaj"))

