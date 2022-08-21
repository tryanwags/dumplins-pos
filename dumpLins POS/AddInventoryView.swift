//
//  AddInventoryView.swift
//  dumpLins POS
//
//  Created by Timothy Wagner on 8/18/22.
//

import SwiftUI

struct AddInventoryView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var inventory = Inventory()
    
    @State private var name: String = ""
    @State private var category: String = ""
    @State private var supply: Int? = nil
    @State private var unitsPerOrder: Int? = nil
    @State private var pricePerOrder: Double? = nil

    let categories = ["Fresh", "Frozen", "Merchandise"]

    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Text("Name")
                        .frame(width: 125, alignment: .leading)
                    Divider()
                    TextField("Name", text: $name)
                }
                Picker("Category", selection: $category) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
                .frame(width: 140, alignment: .leading)
                HStack {
                    Text("Orders Supplied")
                        .frame(width: 125, alignment: .leading)
                    Divider()
                    TextField("Orders Supplied", value: $supply, format: .number)
                    .keyboardType(.decimalPad)
                }
                HStack {
                    Text("Units per Order")
                        .frame(width: 125, alignment: .leading)
                    Divider()
                    TextField("Units per Order", value: $unitsPerOrder, format: .number)
                        .keyboardType(.decimalPad)
                }
                HStack {
                    Text("Price per Order")
                        .frame(width: 125, alignment: .leading)
                    Divider()
                    TextField("Price per Order", value: $pricePerOrder, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
                }

            }
            .navigationTitle("Add new inventory item")
            .toolbar {
                Button("Save") {
                    let item = InventoryItem(name: name,
                                             category: category,
                                             supply: supply!,
                                             unitsPerOrder: unitsPerOrder!,
                                             pricePerOrder: pricePerOrder!)
                    inventory.items.append(item)
                    dismiss()
                }
            }
            
            
        }
        
    }
}
struct AddInventoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddInventoryView()
    }
}
