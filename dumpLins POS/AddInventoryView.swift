//
//  AddInventoryView.swift
//  dumpLins POS
//
//  Created by Timothy Wagner on 8/18/22.
//

import SwiftUI

struct AddInventoryView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var inventory: Inventory
    
    @State private var name = ""
    @State private var category = ""
    @State private var supply = 0
    @State private var unitsPerOrder: Int = 0
    @State private var pricePerOrder: Double = 0.0

    let categories = ["Fresh", "Frozen", "Merchandise"]

    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Text("Name")
                    TextField("Name", text: $name)
                }
                Picker("Category", selection: $category) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
                HStack {
                    Text("Supply")
                    TextField("Supply", value: $supply, format: .number)
                    .keyboardType(.decimalPad)
                }
                HStack {
                    Text("Units per Order")
                    TextField("Units per Order", value: $unitsPerOrder, format: .number)
                        .keyboardType(.decimalPad)
                }
                HStack {
                    Text("Price per Order")
                    TextField("Price per Order", value: $pricePerOrder, format: .number)
                        .keyboardType(.decimalPad)
                }

            }
            .navigationTitle("Add new inventory item")
            .toolbar {
                Button("Save") {
                    let item = InventoryItem(name: name,
                                             category: category,
                                             supply: supply,
                                             unitsPerOrder: unitsPerOrder,
                                             pricePerOrder: pricePerOrder)
                    inventory.items.append(item)
                    dismiss()
                }
            }
            
            
        }
        
    }
}
struct AddInventoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddInventoryView(inventory: Inventory())
    }
}
