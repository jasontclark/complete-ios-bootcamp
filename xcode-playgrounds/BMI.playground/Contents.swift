//: Playground - noun: a place where people can play

import UIKit

// Calculate BMI in Meters and Kg
func calculateBMI(weight : Double, height : Double) -> String {
    let bmi = weight / pow(height, 2)
    
    let shortBMI = String(format: "%.2f", bmi)
    
    if bmi > 25 {
        return "Your BMI is \(shortBMI). You are overweight."
    }
    else if bmi > 18.5 {
        return "Your BMI is \(shortBMI). You have a normal weight."
    }
    else {
        return "Your BMI is \(shortBMI). You are underweight."
    }
}

// Calculate BMI in Weight and Pounds
func bmiCalcImperialUnits(weightInPounds : Double, heightInFeet : Double,
                          remainderInches: Double) -> String {
    
    // Convert from Imperial Units
    let weightinKg = weightInPounds * 0.45359237
    let totalInches = heightInFeet * 12 + remainderInches
    let heightinMeters = totalInches * 0.0254
    
    // Calculate BMI
    let bmi = weightinKg / pow(heightinMeters, 2)
    
    // Two decimal places formatting for the BMI
    let shortBMI = String(format: "%.2f", bmi)
    
    if bmi > 25 {
        return "Your BMI is \(shortBMI). You are overweight."
    }
    else if bmi > 18.5 {
        return "Your BMI is \(shortBMI). You have a normal weight."
    }
    else {
        return "Your BMI is \(shortBMI). You are underweight."
    }
}

print(calculateBMI(weight: 63, height: 1.8))
print(bmiCalcImperialUnits(weightInPounds: 248, heightInFeet: 6, remainderInches: 2))

