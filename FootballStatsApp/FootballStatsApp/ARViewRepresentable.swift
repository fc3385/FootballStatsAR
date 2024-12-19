//
//  ARViewRepresentable.swift
//  FootballStatsApp
//
//  Created by Filippo Caliendo on 11/12/24.
//

import SwiftUI
import RealityKit
import ARKit

struct ARViewRepresentable: UIViewRepresentable {
    @Binding var isModelPlaced: Bool
    private var modelEntity: Entity?

    public init(isModelPlaced: Binding<Bool>) {
        self._isModelPlaced = isModelPlaced
    }

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        arView.setupARSession()
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap))
        arView.addGestureRecognizer(tapGesture)
        let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePan))
        arView.addGestureRecognizer(panGesture)
        let pinchGesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePinch))
        arView.addGestureRecognizer(pinchGesture)
        let rotationGesture = UIRotationGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleRotation))
        arView.addGestureRecognizer(rotationGesture)
        context.coordinator.arView = arView
        context.coordinator.isModelPlaced = $isModelPlaced
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    class Coordinator: NSObject {
        var arView: ARView?
        var isModelPlaced: Binding<Bool>?
        var modelEntity: Entity?
        private var currentPosition: SIMD3<Float>?
        private var currentScale: SIMD3<Float> = SIMD3<Float>(1, 1, 1)
        private var currentRotation: simd_quatf = simd_quatf(angle: 0, axis: [0, 1, 0])
        @objc func handleTap(recognizer: UITapGestureRecognizer) {
            guard let arView = arView else { return }
            let touchLocation = recognizer.location(in: arView)
            if let isModelPlaced = isModelPlaced, isModelPlaced.wrappedValue {
                if let result = arView.raycast(from: touchLocation, allowing: .existingPlaneGeometry, alignment: .horizontal).first,
                   let modelEntity = modelEntity {
                    let newPosition = simd_make_float3(result.worldTransform.columns.3)
                    modelEntity.position = newPosition
                    self.currentPosition = newPosition
                }
            } else {
                if let result = arView.raycast(from: touchLocation, allowing: .existingPlaneGeometry, alignment: .horizontal).first {
                    let position = simd_make_float3(result.worldTransform.columns.3)
                    if let model = try? Entity.load(named: "pitch") {
                        let anchor = AnchorEntity(world: position)
                        anchor.addChild(model)
                        arView.scene.anchors.append(anchor)
                        self.modelEntity = model
                        self.currentPosition = position
                        self.currentScale = SIMD3<Float>(1, 1, 1)
                        self.currentRotation = simd_quatf(angle: 0, axis: [0, 1, 0])
                        isModelPlaced?.wrappedValue = true
                    } else {
                        print("Errore: Impossibile caricare il modello 'pitch'")
                    }
                } else {
                    print("Nessuna superficie valida trovata.")
                }
            }
        }
        @objc func handlePan(recognizer: UIPanGestureRecognizer) {
            guard let arView = arView, let modelEntity = modelEntity, let currentPosition = currentPosition else { return }
            let touchLocation = recognizer.location(in: arView)
            if recognizer.state == .changed {
                if let result = arView.raycast(from: touchLocation, allowing: .existingPlaneGeometry, alignment: .horizontal).first {
                    let newPosition = simd_make_float3(result.worldTransform.columns.3)
                    let translation = newPosition - currentPosition
                    modelEntity.position += translation
                    self.currentPosition = modelEntity.position
                }
            }
        }
        @objc func handlePinch(recognizer: UIPinchGestureRecognizer) {
            guard let modelEntity = modelEntity else { return }

            if recognizer.state == .changed {
                let scaleFactor = Float(recognizer.scale)
                let newScale = currentScale * SIMD3<Float>(repeating: scaleFactor)
                modelEntity.scale = newScale
                self.currentScale = newScale
                recognizer.scale = 1.0
            }
        }

        @objc func handleRotation(recognizer: UIRotationGestureRecognizer) {
            guard let modelEntity = modelEntity else { return }
            if recognizer.state == .changed {
                let angle = Float(recognizer.rotation)
                let rotationDelta = simd_quatf(angle: angle, axis: [0, 1, 0])
                let newRotation = rotationDelta * currentRotation
                modelEntity.orientation = newRotation
                self.currentRotation = newRotation
                recognizer.rotation = 0
            }
        }
    }
}
extension ARView {
    func setupARSession() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        session.run(configuration)
    }
}


