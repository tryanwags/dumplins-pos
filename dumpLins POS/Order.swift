////
////  Order.swift
////  iDine
////
////  Created by Paul Hudson on 27/06/2019.
////  Copyright © 2019 Hacking with Swift. All rights reserved.
////
//
import SwiftUI

class Order {
    var id = UUID()
    var orderId: String = ""

    var date: Date = Date()
    var venue: String = ""
    var customerName: String = ""
//    var items = [InventoryItem]()

    var subTotal: Double {
        return 0 // swap in real logic
    }

    var paymentMethod: String = ""
    var serviceFee: Double = 0.0 // computed based off of payment method
    var discount: Double = 0.0// computed based off bool?

    var total: Double {
        return subTotal * (1 + serviceFee) * (1-discount)
    }

//    var total: Int {
//        if items.count > 0 {
//            return items.reduce(0) { $0 + $1.price }
//        } else {
//            return 0
//        }
//    }

    var note: String = "" // comment (to-go, etc.)  

//    func add(item: InventoryItem) {
//        items.append(item)
//    }
//
//    func remove(item: InventoryItem) {
//        if let index = items.firstIndex(of: item) {
//            items.remove(at: index)
//        }
//    }
}
