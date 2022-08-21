//
//  ContentView.swift
//  dumpLins POS
//
//  Created by Ryan Wagner on 8/12/22.
//

import SwiftUI

// safe area (top of screen)
public var safeAreaTop = UIApplication // safe area at top of screen
    .shared
    .connectedScenes
    .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
    .first { $0.isKeyWindow }!
    .safeAreaInsets.top

public var navbarHeight:CGFloat = 0.14
public var lowerPanelsPadding:CGFloat = 20

// Screen Handler
struct ContentView: View {
    
    @StateObject var inventory = Inventory()
//    @State private var currentVenue: String = ""
    @AppStorage("currentVenue") var currentVenue: String = ""
    
//    @StateObject var orders = Orders()
    @State private var sheetNames = ["NewOrder", "OrderHistory", "Settings"]
    @State private var activeSheet = "NewOrder" // show New Orders on launch
    @State private var navbarLabels = ["New \n Order", "Order \n History", "Settings"] // clean labels for buttons. redundant?
    @State private var touchedNavbarButton:Int = 0 // default to New Orders. Also redundant?
    @AppStorage("timestamp") var timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                // ----------------------------------------------
                // TOP NAVBAR
                // ----------------------------------------------
                VStack {
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [Color("mediumTeal"), Color("pewterBlue")]), startPoint: .leading, endPoint: .trailing)
                        HStack(spacing: 0) {
                            Image("logo") // dumpLins logo
//                            Text("\(timestamp)  |  \(currentVenue)")
                            Text("\(timestamp)  |  \(currentVenue)")
                                .frame(alignment: .center)
                                .padding(.leading, lowerPanelsPadding)
                                .foregroundColor(.white)
                                .opacity(0.6)
                            Spacer()
                            ForEach(0..<navbarLabels.count, id: \.self) { index in  // Item Buttons
                                Button(action:{
                                    touchedNavbarButton = index // highlight selected button
                                    withAnimation(.easeOut(duration: 0.3)) {
                                        activeSheet = sheetNames[index]
                                    }
                                }) {
                                    ZStack {
                                        Color.white
                                            .opacity(touchedNavbarButton == index ? 0.30 : 0.0)
                                            .ignoresSafeArea()
                                        Text(navbarLabels[index]).foregroundColor(.white)
                                    }
                                    .frame(width: 120)
                                }
                            } // end ForEach
                        } // end HStack
                        .padding(EdgeInsets(top: safeAreaTop, leading: 20, bottom: 0, trailing: 20))
                    }
                    .frame(height: (UIScreen.main.bounds.height) * navbarHeight)
                }
                
                // LOWER VIEW TOGGLES ----------------------------------------------
                VStack {
                    if activeSheet == "NewOrder" {
                        NewOrderView(activeSheet: $activeSheet)
//                        NewOrderView(inventory: Inventory(), orders: Orders(), activeSheet: $activeSheet)
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    } else if activeSheet == "OrderHistory" {
                        OrderHistoryView(activeSheet: $activeSheet)
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    } else if activeSheet == "Settings" {
                        SettingsView(activeSheet: $activeSheet)
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    }
                }
            }
            .ignoresSafeArea()

    }
    .ignoresSafeArea(.keyboard)
        
    } // end body
} // end ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
