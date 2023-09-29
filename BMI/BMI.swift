//
//  BMI.swift
//  BMI
//
//  Created by Kristanto Sean on 27/09/23.
//

import Foundation

struct BMI: Codable {
    var weight: Double = 0
    var height: Double = 0
    var bmi: Double = 0
    var weightAdjustment: Double = 0
    var resultTitle: String = ""
    var resultDescription: String = ""
    
    func calculateBMI() -> Double? {
        if height == 0 {
            return nil
        }
        return weight / (height/100 * height/100)
    }
    
    func calculateWeightAdjustment(normalBMI: Double) -> Double {
        let idealWeight = normalBMI * (height/100 * height/100)
        return abs(weight - idealWeight).rounded(toPlaces: 2)
    }
}
