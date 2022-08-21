//
//  SettingsView.swift
//  dumpLins POS
//
//  Created by Timothy Wagner on 8/14/22.
//

import SwiftUI

struct InventoryItem: Identifiable, Equatable, Codable {
    var id = UUID()
    let name: String
    let category: String // fresh/frozen/merchandise
    var supply: Int // orders supplied
    var sold: Int = 0
    var stock: Int { // orders remaining
        return supply-sold
    }
    let unitsPerOrder: Int
    let pricePerOrder: Double

    var buttonColor: Color {
        if stock == 0 {
            return .gray
        } else if category == "Fresh" {
            return Color("Olivine")
        } else if category == "Frozen" {
            return Color("Burnt Sienna")
        } else {
            return Color("Sunray")
        }
    }

    mutating func decrementStock() {
        if stock >= 1 {
            sold += 1
        } else {
            sold = 0
            supply = 3
        }
    }

    mutating func resetSold() {
        sold = 0
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
