//
//  ContentViewModel.swift
//  BMI
//
//  Created by Kristanto Sean on 27/09/23.
//

import Foundation

class ContentViewModel : ObservableObject {
    
    @Published var value = BMI()
    
    func computeResult() {
        value.resultDescription = "Please check your input!"
        if value.weight > 0 && value.height > 0 {
            value.bmi = calculateBMI(weight: value.weight, height: value.height)
            value.resultDescription = generateCategory(bmi: value.bmi)
            value.resultTitle = "Your BMI Index is \(value.bmi.rounded(toPlaces: 2)) kg/m2"
        }else if (value.height == 0 && value.weight > 0){
            value.resultTitle = "Invalid BMI Value (Height Zero)"
        }else if (value.weight < 0 && value.height > 0){
            value.resultTitle = "Invalid BMI Value (Negative Outcome)"
        }else{
            value.resultTitle = "Invalid BMI Value (BMI out of range)"
        }
    }
    
    func calculateBMI(weight:Double, height:Double) -> Double {
        return weight / (height/100 * height/100)
    }
    
    func generateCategory(bmi:Double) -> String{
        let weightAdjustment = calculateWeightAdjustment(bmi: bmi)
        switch (bmi) {
        case 0...16:
            return "Based on your BMI value, you are severely underweight and need to gain \(weightAdjustment) kg"
        case 16...17:
            return "Based on your BMI value, you are moderately underweight and need to gain \(weightAdjustment) kg"
        case 17...18.5:
            return "Based on your BMI value, you are underweight and need to gain \(weightAdjustment) kg"
        case 18.5...25:
            return "Your BMI is normal"
        case 25..<30:
            return "Based on your BMI value, you are overweight and need to lose \(weightAdjustment) kg"
        case 30..<35:
            return "Based on your BMI value, you have Class I Obesity and need to lose \(weightAdjustment) kg"
        case 35..<40:
            return "Based on your BMI value, you have Class II Obesity and need to lose \(weightAdjustment) kg"
        case let bmi where bmi >= 40:
            return "Based on your BMI value, you have Class III Obesity and need to lose \(weightAdjustment) kg"
        default:
            return "Not Found!"
        }
    }
    
    func calculateWeightAdjustment(bmi: Double) -> Double{
        var normalBMI:Double = 0
        if bmi <= 18.5 {
            normalBMI = 18.5
        } else if bmi >= 25 {
            normalBMI = 25
        }
        let idealWeight = normalBMI * (value.height/100 * value.height/100)
        return abs(value.weight - idealWeight).rounded(toPlaces: 2)
    }
}
