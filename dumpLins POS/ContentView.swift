//
//  ContentView.swift
//  dumpLins POS
//
//  Created by Ryan Wagner on 8/12/22.
//

import SwiftUI

public var navbarHeight:CGFloat = 0.12 // full height=768, this leaves a clean 670 pts below navbar
public var lowerPanelsPadding:CGFloat = 20

// Screen Handler
struct ContentView: View {
    
    @State private var sheetNames = ["NewOrder", "OrderHistory", "Settings"]
    @State private var activeSheet = "NewOrder" // show New Orders on launch
    @State private var itemButtonNames = ["New \n Order", "Order \n History", "Settings"] // clean labels for buttons. redundant?
    @State private var touchedNavbarButton:Int = 0 // default to New Orders. Also redundant?
    @AppStorage("currentVenue") private var currentVenue: String = "Benny Boy Brewing Co."
    @AppStorage("timestamp") private var timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)

    var body: some View {
        VStack(spacing: 0) {
            // ----------------------------------------------
            // TOP NAVBAR
            // ----------------------------------------------
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
                            touchedNavbarButton = index // highlight selected button
                            withAnimation(.easeOut(duration: 0.3)) {
                                activeSheet = sheetNames[index]
                            }
                        }) {
                            ZStack {
                                Color.white
                                    .opacity(touchedNavbarButton == index ? 0.30 : 0.0)
                                    .ignoresSafeArea()
                                Text(itemButtonNames[index]).foregroundColor(.white)
                            }
                            .frame(width: 120)
                        }
                    } // end item buttons
                } // end HStack
                .padding([.leading, .trailing], lowerPanelsPadding)
            }
            .frame(height: UIScreen.main.bounds.height * navbarHeight)
        
            // ----------------------------------------------
            // LOWER VIEW TOGGLES
            // ----------------------------------------------
            if activeSheet == "NewOrder" {
                NewOrderView(activeSheet: $activeSheet)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            } else if activeSheet == "OrderHistory" {
                OrderHistoryView(activeSheet: $activeSheet)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            } else if activeSheet == "Settings" {
                SettingsView(activeSheet: $activeSheet)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            }

        } // end outermost VStack
    } // end body
} // end ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
