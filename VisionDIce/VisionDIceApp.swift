//
//  VisionDIceApp.swift
//  VisionDIce
//
//  Created by User on 04.03.24.
//

import SwiftUI

@main
struct VisionDIceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
