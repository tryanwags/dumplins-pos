//
//  SettingsView.swift
//  dumpLins POS
//
//  Created by Timothy Wagner on 8/14/22.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var inventory = Inventory()
    
    @Binding var activeSheet: String
//    @Binding var currentVenue: String
    @AppStorage("currentVenue") var currentVenue: String = ""
    @AppStorage("serviceFee") var serviceFee: Double = 0.036
    @State private var showingAddInventory = false
    @State private var reorderMode: EditMode = .active
    @State private var tableCellWidth: CGFloat = 140
//    @State var venue: String = "Benny Boy Brewing Co."

    let inventoryTableColumns = ["Item", "Category", "Supplied", "Sold", "Stock", "Units per Orders", "Price per Order"]
    
    var body: some View {
        List {
            Section(header: Text("General")) {
                HStack {
                    Text("Venue")
                        .frame(width: 100, alignment: .leading)
                    Divider()
                    TextField("Venue", text: $currentVenue)
                }
                HStack {
                    Text("Service Fee")
                        .frame(width: 100, alignment: .leading)
                    Divider()
                    TextField("Service Fee", value: $serviceFee, format: .number)
                }
                
            }

            Section(header:
                    HStack {
                        Text("Inventory")
                        Spacer()
                        Button {
                            showingAddInventory = true
                        } label: {
                            Image(systemName: "plus")
                        }
//                        Button(reorderMode == .inactive ? "Edit" : "Done") {
//                            reorderMode = reorderMode == .active ? .inactive : .active
//                        }
                    }
            ) {
                HStack {
                    Text("Name").frame(width: 140, alignment: .leading).font(.headline)
                    Text("Category").frame(width: 140, alignment: .leading).font(.headline)
                    Text("Supply").frame(width: 100, alignment: .leading).font(.headline)
                    Text("Sold").frame(width: 100, alignment: .leading).font(.headline)
                    Text("Stock").frame(width: 100, alignment: .leading).font(.headline)
                    Text("Units/Order").frame(width: tableCellWidth, alignment: .leading).font(.headline)
                    Text("Price/Order").frame(width: tableCellWidth, alignment: .leading).font(.headline)
                } // end column header HStack
                .padding(.leading, reorderMode == .active ? 40 : 0)

                ForEach($inventory.items) { $item in
                    HStack {
                        Text(item.name)
                            .frame(width: tableCellWidth, alignment: .leading)
//                        Divider()
                        Text(item.category)
                            .frame(width: tableCellWidth, alignment: .leading)
//                        Divider()
                        Text(String(item.supply))
                            .frame(width: 100, alignment: .leading)
//                        Divider()
                        Text(String(item.sold))
                            .frame(width: 100, alignment: .leading)
//                        Divider()
                        Text(String(item.stock))
                            .frame(width: 100, alignment: .leading)
//                        Divider()
                        Text(item.unitsPerOrder, format: .number)
                            .frame(width: tableCellWidth, alignment: .leading)
//                        Divider()
                        Text(item.pricePerOrder, format: .currency(code: "USD"))
                            .frame(width: tableCellWidth, alignment: .leading)
                    }
                } // end ForEach
                .onDelete(perform: removeItems)
                .onMove(perform: moveItems)
                .sheet(isPresented: $showingAddInventory) {
                    AddInventoryView()
                }
                
//                Button("Reset Quantity Sold") {
//                    inventory.items.forEach { $0.resetSold() }
//                }
                
            } // end section
        
        } // end form
        .environment(\.editMode, $reorderMode)
        .listStyle(.grouped)
    }

    func moveItems(from source: IndexSet, to destination: Int) {
        inventory.items.move(fromOffsets: source, toOffset: destination)
    }
    
    func removeItems(at offsets: IndexSet) {
        inventory.items.remove(atOffsets: offsets)
    }
    
        
} // end struct

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(activeSheet: .constant("XYZ")) // only requires placeholder.
    }
}



