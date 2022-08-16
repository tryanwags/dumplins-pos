//
//  OrderHistoryView.swift
//  dumpLins POS
//
//  Created by Timothy Wagner on 8/14/22.
//

import SwiftUI

// use struct to represent the order template)
struct Order: Identifiable {
    var id = UUID()
    let orderId: Int // paper ticket number
    let date: Date = Date()
    let venue: String
    let customerName: String
//    let items: [String: Int] // dict
    let subTotal: Double
    let paymentMethod: String
    let serviceFee: Double // for card payments
    let discount: Double
    let total: Double
    let note: String // comment ("to go", etc)
}

// use class to store an array of all order instances. Classes that conform to ObservableObject can be used in more than one SwiftUI view
class Orders: ObservableObject {
    @Published var items = [Order]()
}

struct OrderHistoryView: View {
    @Binding var activeSheet: String
    @StateObject var orders = Orders() // create an instance of the Orders class. StateObject asks SwiftUI to watch the object for any change announcements. If a @Published property changes, the view will refresh its body.
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(orders.items) { item in // does not need id: \.name because Order struct is identifiable
                    Text(String(item.orderId))
                    Text(item.customerName)
//                    Text(String(item.items))
                    Text(String(item.subTotal))
                    Text(item.paymentMethod)
                    Text(String(item.total))
                    Text(item.note)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("Order History")
            .toolbar {
                Button {
                    let order = Order(orderId: 12345,
                                      venue: "Benny Boy",
                                      customerName: "Becca",
//                                      items: ["Chicken": 3, "Shiitake": 2, "Kalbi": 1],
                                      subTotal: 54.00,
                                      paymentMethod: "Venmo",
                                      serviceFee: 0.0,
                                      discount: 0.0,
                                      total: 54.00,
                                      note: "All to-go")
                    orders.items.append(order)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        
    }
    
    func removeItems(at offsets: IndexSet) {
        orders.items.remove(atOffsets: offsets)
    }
    
}

struct OrderHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryView(activeSheet: .constant("XYZ")) // only requires placeholder.
    }
}
