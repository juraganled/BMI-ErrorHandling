//
//  ContentViewModel.swift
//  BMI
//
//  Created by Kristanto Sean on 27/09/23.
//

import Foundation

class ContentViewModel : ObservableObject {
    
    @Published var value = BMI()
    
    func doCalculate() {
        let bmiValue = value.calculateBMI()
        guard let bmi = bmiValue else {
            value.resultTitle = "Invalid BMI Value"
            value.resultDescription = "Please check your input!"
            return
        }
        
        value.bmi = bmi
        if value.bmi <= 18.5 {
            value.weightAdjustment = value.calculateWeightAdjustment(normalBMI: 18.5)
        } else if value.bmi >= 25 {
            value.weightAdjustment = value.calculateWeightAdjustment(normalBMI: 25)
        }
        
        var result = ""
        switch (value.bmi) {
        case 0...16:
            result = "Based on your BMI value, you are severely underweight and need to gain \(value.weightAdjustment) kg"
        case 16...17:
            result = "Based on your BMI value, you are moderately underweight and need to gain \(value.weightAdjustment) kg"
        case 17...18.5:
            result = "Based on your BMI value, you are underweight and need to gain \(value.weightAdjustment) kg"
        case 18.5...25:
            result = "Your BMI is normal"
        case 25...30:
            result = "Based on your BMI value, you are overweight and need to lose \(value.weightAdjustment) kg"
        case 30...35:
            result = "Based on your BMI value, you have Class I Obesity and need to lose \(value.weightAdjustment) kg"
        case 35...40:
            result = "Based on your BMI value, you have Class II Obesity and need to lose \(value.weightAdjustment) kg"
        case 40...100:
            result = "Based on your BMI value, you have Class III Obesity and need to lose \(value.weightAdjustment) kg"
        default:
            result = "Not Found!"
        }
        value.resultTitle = "Your BMI Index is \(value.bmi.rounded(toPlaces: 2)) kg/m2"
        value.resultDescription = result
    }
}
