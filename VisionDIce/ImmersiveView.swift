//
//  ImmersiveView.swift
//  VisionDIce
//
//  Created by User on 04.03.24.
//

import SwiftUI
import RealityKit
import RealityKitContent

let diceMap = [
//  + | -
    [1, 6], // x
    [4, 3], // y
    [2, 5], // z
]

struct ImmersiveView: View {
    @State var diceDropped = false
    var diceData: DiceData

    var body: some View {
        RealityView { content in
//            if let scene = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
//                content.add(scene)
//            }
            let floor = ModelEntity(mesh: .generatePlane(width: 50, depth: 50),
                                    materials: [OcclusionMaterial()])
            floor.generateCollisionShapes(recursive: false)
            floor.components[PhysicsBodyComponent.self] = .init(
                massProperties: .default,
                mode: .static
            )
            
            content.add(floor)

            if let diceModel = try? await Entity(named: "cubes"),
               let firstDice = diceModel.children.first?.children.first,
               let secondDice = diceModel.children[1].children.first,
               let thirdDice = diceModel.children[2].children.first,
               let chairsModel = try? await Entity(named: "chairs"),
               let chair = chairsModel.children.first?.children.first,
               let environment = try? await EnvironmentResource(named: "studio")
            {
                setupDice(dice: chairsModel)
                content.add(chairsModel)
                setupDice(dice: chair)
                
//                chairsModel.children.forEach { entityModel in
//                    if let entity = entityModel.children.first {
//                        print(entity)
//                        setupDice(dice: entity)
//                        content.add(entity)
//                    }
//                }
                
//                chairsModel.children.first.forEach({ entity in
//                    entity.first?.children
//                    
//                    setupDice(dice: entity)
//                    print(entity)
//                    content.add(entity)
//                })
                
                setupDice(dice: firstDice)
                setupDice(dice: thirdDice)
                setupDice(dice: secondDice)
                
//                content.add(chair)
//                content.add(firstDice)
//                content.add(secondDice)
//                content.add(thirdDice)
                
                let _ = content.subscribe(to: SceneEvents.Update.self) { event in
                    guard diceDropped else { return }
                    guard let diceMotion = firstDice.components[PhysicsMotionComponent.self] else { return }
                    
                    if simd_length(diceMotion.linearVelocity) < 0.1 &&
                        simd_length(diceMotion.angularVelocity) < 0.1 {
                        let xDirection = firstDice.convert(direction: SIMD3(x: 1, y: 0, z: 0), to: nil)
                        let yDirection = firstDice.convert(direction: SIMD3(x: 0, y: 1, z: 0), to: nil)
                        let zDirection = firstDice.convert(direction: SIMD3(x: 0, y: 0, z: 1), to: nil)
                        
                        let gratestDirection = [
                            0: xDirection.y,
                            1: yDirection.y,
                            2: zDirection.y
                        ]
                            .sorted(by: { abs($0.1) > abs($1.1) })[0]
                        diceData.rolledNumber = diceMap[gratestDirection.key][gratestDirection.value > 0 ? 0 : 1]
                    }
                }
            } else {
                print("something whent wrong")
            }
        }
        .gesture(dragGesture)
    }
    
    private func setupDice(dice: Entity) {
        dice.scale = [0.1,0.1,0.1]
        dice.position.y = 0.5
        dice.position.z = -1
        
        dice.generateCollisionShapes(recursive: false)
        dice.components.set(InputTargetComponent())
        
//        dice.components.set(ImageBasedLightComponent(source: .single(environment)))
        dice.components.set(ImageBasedLightReceiverComponent(imageBasedLight: dice))
        dice.components.set(GroundingShadowComponent(castsShadow: true))
        
        dice.components[PhysicsBodyComponent.self] = .init(PhysicsBodyComponent(
            massProperties: .default,
            material: .generate(
                staticFriction: 0.8,
                dynamicFriction: 0.5,
                restitution: 0.1),
            mode: .dynamic
        ))
        dice.components[PhysicsMotionComponent.self] = .init()
    }
    
    var dragGesture: some Gesture {
        DragGesture()
            .targetedToAnyEntity()
            .onChanged({ value in
                value.entity.position = value.convert(
                    value.location3D,
                    from: .local,
                    to: value.entity.parent!)
                value.entity.components[PhysicsBodyComponent.self]?.mode = .kinematic
            })
            .onEnded { value in
                value.entity.components[PhysicsBodyComponent.self]?.mode = .dynamic
                
                if !diceDropped {
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                         diceDropped = true
                    }
                }
            }
    }
}

#Preview {
    ImmersiveView(diceData: DiceData())
        .previewLayout(.sizeThatFits)
}
