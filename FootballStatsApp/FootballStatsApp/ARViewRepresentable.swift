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

        // Gesti per interagire con il modello
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap))
        arView.addGestureRecognizer(tapGesture)

        let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePan))
        arView.addGestureRecognizer(panGesture)

        let pinchGesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePinch))
        arView.addGestureRecognizer(pinchGesture)

        context.coordinator.arView = arView
        context.coordinator.isModelPlaced = $isModelPlaced

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        // Nessun aggiornamento dinamico richiesto
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    class Coordinator: NSObject {
        var arView: ARView?
        var isModelPlaced: Binding<Bool>?
        var modelEntity: Entity?

        // Variabili per memorizzare stato corrente di posizione e scala
        private var currentPosition: SIMD3<Float>?
        private var currentScale: SIMD3<Float> = SIMD3<Float>(1, 1, 1)

        @objc func handleTap(recognizer: UITapGestureRecognizer) {
            guard let arView = arView, let isModelPlaced = isModelPlaced, !isModelPlaced.wrappedValue else { return }

            let touchLocation = recognizer.location(in: arView)

            if let result = arView.raycast(from: touchLocation, allowing: .existingPlaneGeometry, alignment: .horizontal).first {
                let position = simd_make_float3(result.worldTransform.columns.3)

                if let model = try? Entity.load(named: "Scene") {
                    let anchor = AnchorEntity(world: position)
                    anchor.addChild(model)
                    arView.scene.anchors.append(anchor)

                    // Memorizza il modello e la posizione iniziale
                    self.modelEntity = model
                    self.currentPosition = position
                    self.currentScale = SIMD3<Float>(1, 1, 1)
                    isModelPlaced.wrappedValue = true
                } else {
                    print("Errore: Impossibile caricare il modello 'Scene'")
                }
            } else {
                print("Nessuna superficie valida trovata.")
            }
        }

        @objc func handlePan(recognizer: UIPanGestureRecognizer) {
            guard let arView = arView, let modelEntity = modelEntity, let currentPosition = currentPosition else { return }

            let touchLocation = recognizer.location(in: arView)

            if recognizer.state == .changed {
                if let result = arView.raycast(from: touchLocation, allowing: .existingPlaneGeometry, alignment: .horizontal).first {
                    let newPosition = simd_make_float3(result.worldTransform.columns.3)

                    // Calcola il delta di movimento
                    let translation = newPosition - currentPosition

                    // Aggiorna la posizione del modello
                    modelEntity.position += translation
                    self.currentPosition = modelEntity.position // Salva la nuova posizione
                }
            }
        }

        @objc func handlePinch(recognizer: UIPinchGestureRecognizer) {
            guard let modelEntity = modelEntity else { return }

            if recognizer.state == .changed {
                // Calcola la nuova scala basandosi sul fattore corrente
                let scaleFactor = Float(recognizer.scale)
                let newScale = currentScale * SIMD3<Float>(repeating: scaleFactor)

                // Applica la nuova scala al modello
                modelEntity.scale = newScale
                self.currentScale = newScale // Salva la nuova scala

                // Resetta il gesto per scalatura incrementale
                recognizer.scale = 1.0
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
