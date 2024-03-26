//
//  VisionDIceApp.swift
//  VisionDIce
//
//  Created by User on 04.03.24.
//

import SwiftUI

@Observable
class DiceData {
    var rolledNumber = 0
}

@main
struct VisionDIceApp: App {
    @State var diceData = DiceData()
    
    var body: some Scene {
        WindowGroup {
            ContentView(diceData: diceData )
        }
//        .defaultSize(width: 100, height: 100)

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView(diceData: diceData, elemen: ["bla", "blo"])
        }
    }
}
