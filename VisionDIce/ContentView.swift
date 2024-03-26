//
//  ContentView.swift
//  VisionDIce
//
//  Created by User on 04.03.24.
//

import SwiftUI

struct ContentView: View {

    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    var diceData: DiceData
    
    var body: some View {
        NavigationSplitView {
            VStack {
                Text("Vision pro App!")
//                Text(diceData.rolledNumber == 0 ? "🎲" : "\(diceData.rolledNumber)")
                Text("🤩")
                    .foregroundStyle(.yellow)
                    .font(.custom("Menlo", size: 100))
                    .bold()
                
                NavigationLink(destination: ObjectContentView(objectName: "Dice Object")) {
                    Text("Dice Object")
                        .padding()
                }
                
                NavigationLink(destination: ObjectContentView(objectName: "Cubes Set")) {
                    Text("Cubes Set")
                }
                
                NavigationLink(destination: ObjectContentView(objectName: "Table Set")) {
                    Text("Table Set")
                }
                
                Toggle("Show Immersive Space", isOn: $showImmersiveSpace)
                    .toggleStyle(.button)
                    .padding(.top, 25)

            }
            .onChange(of: showImmersiveSpace) { _, newValue in
            Task {
                if newValue {
                    switch await openImmersiveSpace(id: "ImmersiveSpace", value: ["bla"]) {
                    case .opened:
                        immersiveSpaceIsShown = true
                    case .error, .userCancelled:
                        fallthrough
                    @unknown default:
                        immersiveSpaceIsShown = false
                        showImmersiveSpace = false
                    }
                } else if immersiveSpaceIsShown {
                    await dismissImmersiveSpace()
                    immersiveSpaceIsShown = false
                }
            }
        }
            .padding()
            .navigationTitle("VisionDIce")
        } detail: {
            Text("Detail To Be implementd")
        }
    }
}
