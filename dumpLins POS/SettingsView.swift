//
//  SettingsView.swift
//  dumpLins POS
//
//  Created by Timothy Wagner on 8/14/22.
//

import SwiftUI

struct InventoryItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let category: String // fresh/frozen/merchandise
    let supply: Int // orders supplied
    var sold: Int = 0
    var stock: Int { // orders remaining
        return supply-sold
    }
    let unitsPerOrder: Int
    let pricePerOrder: Double
    
    var buttonColor: Color {
        if category == "Fresh" {
            return Color("Olivine")
        } else if category == "Frozen" {
            return Color("Burnt Sienna")
        } else {
            return Color("Sunray")
        }
    }
    
    mutating func decrementStock() {
        sold += 1
    }
    
}

class Inventory: ObservableObject {
    @Published var items = [InventoryItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([InventoryItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}

//class Inventory: ObservableObject {
//    @Published var items:[String:InventoryDescriptor] = [:]
//}

//print(inventory["chicken"]!.supply)

struct SettingsView: View {
    @Binding var activeSheet: String
    @State private var showingAddInventory = false
    
    @StateObject var inventory = Inventory()
    
    func removeItems(at offsets: IndexSet) {
        inventory.items.remove(atOffsets: offsets)
    }
    
    var body: some View {
        
        Button {
            showingAddInventory = true
        } label: {
            Image(systemName: "plus")
        }
        .padding()
            
        List {
            HStack {
                Text("Item")
                    .frame(width: 125, alignment: .leading)
                Divider()
                Text("Category")
                    .frame(width: 125, alignment: .leading)
                Divider()
                Text("Orders Supplied")
                    .frame(width: 125, alignment: .leading)
                Divider()
                Text("Units per Order")
                    .frame(width: 125, alignment: .leading)
                Divider()
                Text("Price per Order")
                    .frame(width: 125, alignment: .leading)
            }
//
            ForEach(inventory.items) { item in
                HStack {
                    Text(item.name)
                        .frame(width: 125, alignment: .leading)
                    Divider()
                    Text(item.category)
                        .frame(width: 125, alignment: .leading)
                    Divider()
                    Text(String(item.supply))
                        .frame(width: 125, alignment: .leading)
                    Divider()
                    Text(item.unitsPerOrder, format: .number)
                        .frame(width: 125, alignment: .leading)
                    Divider()
                    Text(item.pricePerOrder, format: .currency(code: "USD"))
                        .frame(width: 125, alignment: .leading)
                }
            }
            .onDelete(perform: removeItems)
            .sheet(isPresented: $showingAddInventory) {
                AddInventoryView(inventory: inventory)
            }

        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(activeSheet: .constant("XYZ")) // only requires placeholder.
    }
}
