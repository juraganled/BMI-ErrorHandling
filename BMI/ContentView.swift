//
//  ContentView.swift
//  BMI
//
//  Created by Kristanto Sean on 27/09/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    @State var weightString = "0"
    @State var heightString = "0"
    @State var showAlert = false
    @State var errorMessage = "Unknown error"
    
    var body: some View {
        VStack {
            Form {
                
                Section("Weight"){
                    TextField("Weight", text: $weightString)
                        .keyboardType(.numbersAndPunctuation)
                }

                Section("Height"){
                    TextField("Height", text: $heightString)
                        .keyboardType(.numbersAndPunctuation)
                }

                Button("Calculate") {
                    do {
                        try viewModel.computeResult(weightString: weightString, heightString: heightString)
                    } catch BMIError.weightZero {
                        errorMessage = "Weight cannot be zero"
                    } catch BMIError.heightZero {
                        errorMessage = "Height cannot be zero"
                    } catch BMIError.weightHeightZero {
                        errorMessage = "Invalid BMI Value (BMI out of range)"
                    } catch BMIError.weightNonNumber {
                        errorMessage = "Weight is not number"
                    } catch BMIError.heightNonNumber {
                        errorMessage = "Height is not number"
                    } catch BMIError.negativeOutcome {
                        errorMessage = "Invalid BMI Value (Negative Outcome)"
                    } catch {
                        errorMessage = "Unknown error"
                    }
                }
                .listRowBackground(Color.clear)
                .buttonStyle(.borderedProminent)

                Section("Result") {
                    VStack(alignment: .leading) {
                        Text(viewModel.value.resultTitle)
                        Text(viewModel.value.resultDescription)
                    }
                }
            }
        }
        .onChange(of: errorMessage, {
            showAlert = true
        })
        .alert("Error", isPresented: $showAlert) {
            Text(errorMessage)
            Button("OK") {
                showAlert = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
