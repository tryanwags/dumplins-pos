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
//
//// order template (a struct to represent a single item of expense)
////struct Order: Identifiable { // Identifible protocol has only one requirement: there must be a property called 'id' that contains a unique identifier.
////    let id = UUID()
////    let date: Date
////    let venue: String
////    let orderId: Int
////    let customerName: String
////    let items: [String] // dict?
////    let subTotal: Double
////    let paymentMethod: String // for card payments
////    let serviceFee: Double
////    let discount: Double
////    let total: Double
////    let status: String
////}
//
//// a class to store an array of all those items
////class Orders: ObservableObject { // classes that conform to ObservableObject can be used in more than one SwiftUI view
////    @Published var orders = [Order]()
////}
//
//// Orders screen
struct ContentView: View {
    
    @State private var navbarHeight = 0.12
////    @AppStorage("orderHistory") private var orderHistory: String = "" // need to persist all orders in case app is hard closed
//    @AppStorage("currentVenue") private var currentVenue: String = "Benny Boy Brewing Co."
//
//    @State private var timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)
//    @State private var showSettingsScreen = false
//    @State private var buttonText = (1...11).map { "Item \($0)" }
//    @State private var buttonColumns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
//    @State private var hStackPadding:CGFloat = 20
//
////    @StateObject var orders = Orders()
//
//    // calculate row count based on num cols
//    private var rowCount:CGFloat {
//        return ceil( CGFloat(buttonText.count) / CGFloat(buttonColumns.count))
//    }
//
//    // calculate dynamic button height
//    private var buttonHeight:CGFloat {
//        let allPadding = ((rowCount * 2) - 1) * (hStackPadding/2) // padding around/between buttons
//        let final = (UIScreen.main.bounds.height * (1-globalSettings.navbarHeight) - allPadding)/rowCount
//        return final
//    }
//
//    // item button template
//    struct itemButton: View {
//        var item: String
//        var stock: Int = 0
//        var buttonHeight: CGFloat
//
//        func buttonPress() {
//            print("BUTTON")
//        }
//
//        var body: some View {
//            Button( action: { buttonPress() }) {
//                VStack(alignment: .leading) {
//                    Text("\(item)")
//                    Text("Stock: \(stock)")
//                }
//            }
//            .frame(maxWidth: .infinity, minHeight: buttonHeight)
//            .background(Color("olivine"))
//            .foregroundColor(.white)
//            .cornerRadius(30)
//        }
//    }
//
    var body: some View {
        
        VStack(spacing: 0) {
            // --------------------------------------------------------------------
            // TOP NAVBAR
            // --------------------------------------------------------------------
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("mediumTeal"), Color("pewterBlue")]), startPoint: .leading, endPoint: .trailing)
//                HStack(spacing: 0) {
//                    Image("logo") // dumpLins logo
//                        .padding()
//                    Text("\(timestamp)  |  \(currentVenue)")
//                        .frame(minWidth: 500)
//                        .foregroundColor(.white)
//                        .opacity(0.5)
//                        .padding(.top)
//                    Spacer()
//                    Spacer()
//
//                    // NEW ORDERS sheet toggle
//                    Button( action: { showSettingsScreen = false }) {
//                        ZStack {
//                            Color.white.opacity(!showSettingsScreen ? 0.30 : 0.0)
//                            Text("New Order")
//                                .foregroundColor(.white)
//                                .padding(.top)
//                        }
//                    }
//
//                    // SETTINGS sheet toggle
//                    Button( action: { showSettingsScreen = true }) {
//                        ZStack {
//                            Color.white.opacity(showSettingsScreen ? 0.30 : 0.0)
//                            Text("Settings")
//                                .foregroundColor(.white)
//                                .padding(.top)
//                        }
//                    }
////                    .sheet(isPresented: $showSettingsScreen) {
////                        SettingsView()
////                    }
//                }
            }
            .frame(height: UIScreen.main.bounds.height * navbarHeight)
//
//            // --------------------------------------------------------------------
//            // LOWER SECTIONS
//            // --------------------------------------------------------------------
//            HStack(spacing: 0) {
//                // LOWER LEFT ---------------------
//                ZStack {
//                    Color.white
//                    // Button grid
//                    LazyVGrid(columns: buttonColumns, spacing: 10) {
//                        ForEach(buttonText, id: \.self) { item in
//                            itemButton(item: item, buttonHeight: buttonHeight)
//                        }
//                    }
//                }
//                .padding(EdgeInsets(top: hStackPadding, leading: hStackPadding, bottom: hStackPadding, trailing: hStackPadding/2))
//
//                // LOWER RIGHT --------------------
//                ZStack {
//                    Color.white
//                }
//                .padding(EdgeInsets(top: hStackPadding, leading: hStackPadding/2, bottom: hStackPadding, trailing: hStackPadding))
//            }
        }
        .ignoresSafeArea()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
