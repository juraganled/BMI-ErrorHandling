//
//  ContentView.swift
//  BMI
//
//  Created by Kristanto Sean on 27/09/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            Form {
                Section("Weight"){
                    TextField("Weight", value: $viewModel.value.weight, formatter: NumberFormatter())
                }

                Section("Height"){
                    TextField("Height", value: $viewModel.value.height, formatter: NumberFormatter())
                }

                Button("Calculate") {
                    viewModel.doCalculate()
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
