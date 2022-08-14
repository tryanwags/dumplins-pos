//
//  ContentView.swift
//  dumpLins POS
//
//  Created by Ryan Wagner on 8/12/22.
//

import SwiftUI

//// global settings
//struct globalSettings {
//    static var navbarHeight = 0.12 // percentage of screen height
//    static var currentDate = Date.now
//}

// order template (use struct to reppresent the template)
struct Order: Identifiable { // Identifible protocol has only one requirement: there must be a property called 'id' that contains a unique identifier.
    let id = UUID()
    let date: Date
    let venue: String
    let orderId: Int
    let customerName: String
    let items: [String] // dict?
    let subTotal: Double
    let paymentMethod: String // for card payments
    let serviceFee: Double
    let discount: Double
    let total: Double
    let status: String
}
//
// a class to store an array of all those items
class Orders: ObservableObject { // classes that conform to ObservableObject can be used in more than one SwiftUI view
    @Published var orders = [Order]()
}
//
//// Orders screen
struct ContentView: View {

//    let topPadding = x.safeAreaInsets.top
//    let bottomPadding = x.safeAreaInsets.bottom
    
    @State private var navbarHeight:CGFloat = 0.12 // full height=768, this leaves a clean 670 pts below navbar
    @State private var lowerPanelsPadding:CGFloat = 20
    @State private var numButtonColumns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
    @State private var buttonText = (1...11).map { "Item \($0)" }
    @State private var itemButtonNames = ["New \n Order", "Order \n History", "Settings"]
    @State private var touchedButton:Int = 0 // default to New Orders
    
//    @AppStorage("orderHistory") private var orderHistory: String = "" // need to persist all orders in case app is hard closed
    @AppStorage("currentVenue") private var currentVenue: String = "Benny Boy Brewing Co."
    @AppStorage("timestamp") private var timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)
//    @State private var showSettingsScreen = false

//    @StateObject var orders = Orders()

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
        
        VStack(spacing: 0) {
            // --------------------------------------------------------------------
            // TOP NAVBAR
            // --------------------------------------------------------------------
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("mediumTeal"), Color("pewterBlue")]), startPoint: .leading, endPoint: .trailing)
                    .ignoresSafeArea()
                
                HStack(spacing: 0) {
                    Image("logo") // dumpLins logo
                    Text("\(timestamp)  |  \(currentVenue)")
                        .frame(alignment: .center)
                        .padding(.leading, lowerPanelsPadding)
                        .foregroundColor(.white)
                        .opacity(0.6)
                    Spacer()
                    // Item Buttons
                    ForEach(0..<itemButtonNames.count, id: \.self) { index in
                        Button(action:{
                            touchedButton = index
                            print(touchedButton)
                            
                        }) {
                            ZStack {
                                Color.white
                                    .opacity(touchedButton == index ? 0.30 : 0.0)
                                    .ignoresSafeArea()
                                Text(itemButtonNames[index]).foregroundColor(.white)
                            }
                            .frame(width: 120)
                        }
                    } // end iem buttons
                    
                } // end HStack
                .padding([.leading, .trailing], lowerPanelsPadding)
            }
            .frame(height: UIScreen.main.bounds.height * navbarHeight)

            // --------------------------------------------------------------------
            // LOWER SECTIONS
            // --------------------------------------------------------------------
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
                }
                .padding(.leading, 10)

            } // end HStack (lower sections)
            .padding(lowerPanelsPadding) // align with padding in lower panels
//
        } // end outermost VStack
    } // end body
} // end ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
