//
//  ContentView.swift
//  WeSplit
//
//  Created by Sebastian Cioată on 11.03.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    var dollarFormat: FloatingPointFormatStyle<Double>.Currency{
        let currencyCode = Locale.current.currency?.identifier ?? "USD"

        return FloatingPointFormatStyle<Double>.Currency(code: currencyCode)
    }
    
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount/100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                Section{
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(0..<101, id:\.self){
                            Text($0, format:.percent)
                        }
                    }
                    .pickerStyle(.automatic)
                } header:{
                    Text("How much tip do you want to leave?")
                }
                Section{
                    Text(totalPerPerson, format: dollarFormat)
                } header:{
                    Text("Amount per person")
                }
                Section{
                    Text((checkAmount + checkAmount/100 * Double(tipPercentage)), format: dollarFormat)
                        .foregroundColor(tipPercentage == 0 ? .red : .black)
                }
                
            header: {
                    Text("The original amount and the tip value")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    
                    Button("Done"){
                        amountIsFocused = false
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
