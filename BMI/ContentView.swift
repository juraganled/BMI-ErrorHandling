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
    var body: some View {
        VStack {
            Form {
                Section("Weight"){
                    TextField("Weight", text: $weightString)
                        .keyboardType(.numberPad)
                }

                Section("Height"){
                    TextField("Height", text: $heightString)
                        .keyboardType(.numberPad)
                }

                Button("Calculate") {
                    viewModel.value.weight = Double(weightString) ?? 0
                    viewModel.value.height = Double(heightString) ?? 0
                    viewModel.computeResult()
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
