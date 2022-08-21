//
//  NewOrderView.swift
//  dumpLins POS
//
//  Created by Timothy Wagner on 8/14/22.
//

import SwiftUI

struct NewOrderView: View {
    
    @StateObject var inventory = Inventory()
    
    @Binding var activeSheet: String
    @State private var numButtonColumns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
    @State private var buttonText = (1...11).map { "Item \($0)" }
    
    // current order fields
    @State private var orderId: String = ""
    @State private var venue: String = "Benny Boy"
    @State private var customerName: String = ""
//    @State private var items: [String: Int] = []
    @State private var subTotal: Double = 0.0
    @State private var paymentMethod: String = ""
    let paymentMethods = ["Venmo", "Card", "Cash", "Zelle", "Comp"]
    @State private var serviceFee: Double = 0.0
    @State private var discount: Double = 0.0
    @State private var note: String = ""
    
    private var total: Double {
        return subTotal * 10.0
    }
    
    // calculate row count based on num cols
    public var rowCount:CGFloat {
        return ceil( CGFloat(buttonText.count) / CGFloat(numButtonColumns.count))
    }
    
    // calculate dynamic item button height
    var buttonHeight:CGFloat {
        let safeAreaTop = UIApplication // safe area at top of screen
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }!
            .safeAreaInsets.top
        let allPadding = ((rowCount * 2) - 1) * (lowerPanelsPadding/2) + safeAreaTop // sum of all padding around/between buttons
        let final = (UIScreen.main.bounds.height * (1-navbarHeight) - allPadding)/rowCount // thank you algebra
        return final
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                
                // LOWER LEFT (item button grid) ---------------------
                LazyVGrid(columns: numButtonColumns, spacing: 10) { // does NOT add spacing above/below outermost rows, ONLY in between cells.
                    
                    ForEach($inventory.items) { $item in
                        Button(action: {
                            item.decrementStock()
                        }) {
                            VStack(alignment: .leading) {
                                Text(item.category == "Frozen" ? "\(item.name) (Frozen)" : item.name)
                                    .frame(alignment: .leading)
                                Text("Stock: \(item.stock)")
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: buttonHeight)
                        .background(item.buttonColor)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        
                    }
                }
                .padding(lowerPanelsPadding) // align with padding in lower panels
                
                // LOWER RIGHT (order summary) ------------------------
                VStack {
//                    Color("lightTeal").opacity(0.25)
//                    NavigationView {
                        Form {
                            TextField("Order ID", text: $orderId)
//                                .keyboardType(.numberPad)
                            TextField("Customer Name", text: $customerName)
                            
                            Picker("Payment Method", selection: $paymentMethod) {
                                ForEach(paymentMethods, id: \.self) {
                                    Text($0)
                                }
                            }
                            
                            Text("Subtotal: \(subTotal)")
                            TextField("Discount", value: $discount, format: .currency(code: "USD"))
                            Text("Total: \(total)")
                            TextField("Note", text: $note)
                            
                        }
                        .frame(height: 400)
                    
                    
//                    Button("Save") {
//                        let order = Order(orderId: orderId,
//                                          venue: venue,
//                                          customerName: customerName,
//                                          subTotal: subTotal,
//                                          paymentMethod: paymentMethod,
//                                          serviceFee: serviceFee,
//                                          discount: discount,
//                                          total: total,
//                                          note: note)
//                        orders.items.append(order)
//                    }
                    

                }
//                .padding(lowerPanelsPadding) // align with padding in lower panels
//                .padding(.leading, 10)

            } // end HStack (lower sections)
            .ignoresSafeArea(.keyboard)
//
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct NewOrderView_Previews: PreviewProvider {
    static var previews: some View {
        NewOrderView(activeSheet: .constant("XYZ"))
    }
}
