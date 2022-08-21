//
//  OrderHistoryView.swift
//  dumpLins POS
//
//  Created by Timothy Wagner on 8/14/22.
//

import SwiftUI

struct OrderHistoryView: View {
    @Binding var activeSheet: String

    var body: some View {
            ZStack {
                Color.white
                Text("HELLO")
            }
            .frame(height: UIScreen.main.bounds.height * (1-navbarHeight))
    }
}

struct OrderHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryView(activeSheet: .constant("XYZ")) // only requires placeholder.
    }
}
