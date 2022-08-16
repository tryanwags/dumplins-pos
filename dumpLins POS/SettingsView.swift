//
//  SettingsView.swift
//  dumpLins POS
//
//  Created by Timothy Wagner on 8/14/22.
//

import SwiftUI

struct SettingsView: View {
    @Binding var activeSheet: String
    
    var body: some View {
        ZStack {
            Color.white
            Text("SETTINGS")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(activeSheet: .constant("XYZ")) // only requires placeholder.
    }
}
