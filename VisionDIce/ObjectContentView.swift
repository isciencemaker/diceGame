//
//  ObjectContentView.swift
//  VisionDIce
//
//  Created by User on 22.03.24.
//

import SwiftUI
import RealityKit

struct ObjectContentView: View {
    let objectName: String
    let entities: [Entity] = [Entity]() // should be removed in the future
//    let immersiveView: ImmersiveView
    
    init(objectName: String/*, immersiveView: ImmersiveView*/) {
        self.objectName = objectName
//        self.immersiveView = immersiveView
    }
    
    var body: some View {
        VStack {
            ForEach(entities, id: \.self) { entity in
                Text(entity.name)
            }
            
            if objectName == "Dice Object" {
                Button {
                    print("Dice Object Button 1 tapped")
                } label: {
                    Text("Dice Object Button 1")
                }
                .padding()
                
                Button {
                    print("Dice Object Button 2 tapped")
                } label: {
                    Text("Dice Object Button 2")
                }
                .padding()
                
                Button {
                    print("Dice Object Button 3 tapped")
                } label: {
                    Text("Dice Object Button 3")
                }
                .padding()
            } else if objectName == "Cubes Set" {
                Button {
                    print("Cubes Set Button 1 tapped")
                } label: {
                    Text("Cubes Set Button 1")
                }
                .padding()
                
                Button {
                    print("Cubes Set Button 2 tapped")
                } label: {
                    Text("Cubes Set Button 2")
                }
                .padding()
                
                Button {
                    print("Cubes Set Button 3 tapped")
                } label: {
                    Text("Cubes Set Button 3")
                }
                .padding()
            } else if objectName == "Table Set" {
                Button {
                    print("Table Set Button 1 tapped")
                } label: {
                    Text("Table Set Button 1")
                }
                .padding()
                
                Button {
                    print("Table Set Button 2 tapped")
                } label: {
                    Text("Table Set Button 2")
                }
                .padding()
                
                Button {
                    print("Table Set Button 3 tapped")
                } label: {
                    Text("Table Set Button 3")
                }
                .padding()
            }
        }
    }
}

