//
//  NewOrderView.swift
//  dumpLins POS
//
//  Created by Timothy Wagner on 8/14/22.
//

import SwiftUI

struct NewOrderView: View {
    @Binding var activeSheet: String
    @State private var numButtonColumns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
    @State private var buttonText = (1...11).map { "Item \($0)" }
//    @State private var itemButtonNames = ["New \n Order", "Order \n History", "Settings"]
//    @State private var touchedNavbarButton:Int = 0 // default to New Orders
    
    // current order fields
    @State private var orderId: Int? = nil
    @State private var venue: String = "Benny Boy"
    @State private var customerName: String = ""
//    @State private var items: [String: Int] = []
    @State private var subTotal: Double = 0.0
    @State private var paymentMethod: String = ""
    @State private var serviceFee: Double = 0.0
    @State private var discount: Double = 0.0
//    @State private var total: Double = 0.0
    @State private var note: String = ""
    
    let paymentMethods = ["Venmo", "Card", "Cash", "Zelle", "Comp"]
    
    private var total: Double {
        return subTotal * 10.0
    }
    
    // calculate row count based on num cols
    private var rowCount:CGFloat {
        return ceil( CGFloat(buttonText.count) / CGFloat(numButtonColumns.count))
    }

    // calculate dynamic item button height
    private var itemButtonHeight:CGFloat {
        // safe area at top of screen
        let safeAreaTop = UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }!
            .safeAreaInsets.top
        let allPadding = ((rowCount * 2) - 1) * (lowerPanelsPadding/2) + safeAreaTop // sum of all padding around/between buttons
        let final = (UIScreen.main.bounds.height * (1-navbarHeight) - allPadding)/rowCount // thank you algebra
//        let final = ((UIScreen.main.bounds.height - navbarHeight) - allPadding)/rowCount // thank you algebra
        return final
    }

    // item button template
    struct itemButton: View {
        var item: String
        var stock: Int = 0
        var buttonHeight: CGFloat

        func buttonPress() {
            print("BUTTON")
        }

        var body: some View {
            Button( action: { buttonPress() }) {
                VStack(alignment: .leading) {
                    Text("\(item)")
                    Text("Stock: \(stock)")
                }
            }
            .frame(maxWidth: .infinity, minHeight: buttonHeight)
            .background(Color("olivine"))
            .foregroundColor(.white)
            .cornerRadius(30)
        }
    }
    
    var body: some View {
        
//        VStack(spacing: 0) {


            HStack(spacing: 0) {
                
                // LOWER LEFT (item button grid) ---------------------
                LazyVGrid(columns: numButtonColumns, spacing: 10) { // does NOT add spacing above/below outermost rows, ONLY in between cells.
                    ForEach(buttonText, id: \.self) { item in
//                        Color.green.frame(height: buttonHeight)
                        itemButton(item: item, buttonHeight: itemButtonHeight)
                    }
                }
                .padding(.trailing, 10)
                
                // LOWER RIGHT (order summary) ------------------------
                ZStack {
                    Color("lightTeal").opacity(0.25)
//                    NavigationView {
                        Form {
                            TextField("Order ID", value: $orderId, format: .number)
                            TextField("Customer Name", text: $customerName)
                            Picker("Payment Method", selection: $paymentMethod) {
                                ForEach(paymentMethods, id: \.self) {
                                    Text($0)
                                }
                            }
                            Text("Subtotal: \(subTotal)")
                            Text("Total: \(total)")
                            TextField("Note", text: $note)
                            
                        }
//                    }
                }
                .padding(.leading, 10)

            } // end HStack (lower sections)
            .padding(lowerPanelsPadding) // align with padding in lower panels
//
//        } // end outermost VStack
        
        
    }
}

struct NewOrderView_Previews: PreviewProvider {
    static var previews: some View {
        NewOrderView(activeSheet: .constant("XYZ")) // only requires placeholder.
    }
}
