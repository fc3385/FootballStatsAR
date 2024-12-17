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
    @Binding var isModelPlaced: Bool // Stato per controllare se il modello è stato posizionato
    private var modelEntity: Entity?

    // Modifica il costruttore rendendolo pubblico
    public init(isModelPlaced: Binding<Bool>) {
        self._isModelPlaced = isModelPlaced
    }

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        arView.setupARSession()

        // Aggiungere un gesto di tap per posizionare il modello
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap))
        arView.addGestureRecognizer(tapGesture)

        // Gesti di pan (trascinamento) e pinch (scalamento)
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

        @objc func handleTap(recognizer: UITapGestureRecognizer) {
            guard let arView = arView, let isModelPlaced = isModelPlaced, !isModelPlaced.wrappedValue else { return }

            // Ottieni la posizione del tocco nello spazio 2D dello schermo
            let touchLocation = recognizer.location(in: arView)

            // Effettua un raycast per trovare una superficie orizzontale
            if let result = arView.raycast(from: touchLocation, allowing: .existingPlaneGeometry, alignment: .horizontal).first {
                // Ottieni la posizione del punto toccato nello spazio 3D
                let position = simd_make_float3(result.worldTransform.columns.3)

                // Carica il modello
                if let model = try? Entity.load(named: "Experience") {
                    // Crea un ancoraggio e posiziona il modello
                    let anchor = AnchorEntity(world: position)
                    anchor.addChild(model)
                    arView.scene.anchors.append(anchor)

                    // Memorizza il modello per usarlo con i gesti
                    self.modelEntity = model
                    isModelPlaced.wrappedValue = true
                } else {
                    print("Errore: Impossibile caricare il modello 'Experience'")
                }
            } else {
                print("Nessuna superficie valida trovata.")
            }
        }

        // Gestione del trascinamento (spostamento del modello)
        @objc func handlePan(recognizer: UIPanGestureRecognizer) {
            guard let arView = arView, let modelEntity = modelEntity else { return }

            let touchLocation = recognizer.location(in: arView)
            
            if recognizer.state == .changed {
                // Esegui un raycast per determinare dove si trova la superficie
                let raycastResult = arView.raycast(from: touchLocation, allowing: .existingPlaneGeometry, alignment: .horizontal)
                
                if let hitTest = raycastResult.first {
                    // Ottieni la nuova posizione e sposta il modello
                    let newPosition = simd_make_float3(hitTest.worldTransform.columns.3)
                    modelEntity.position = newPosition
                }
            }
        }

        // Gestione del pinch (scalamento del modello)
        @objc func handlePinch(recognizer: UIPinchGestureRecognizer) {
            guard let arView = arView, let modelEntity = modelEntity else { return }

            if recognizer.state == .changed {
                // Scala il modello in base al gesto di pinch
                modelEntity.scale = SIMD3<Float>(repeating: Float(recognizer.scale))
            }
        }
    }
}

extension ARView {
    func setupARSession() {
        // Configurazione dell'AR session per il rilevamento di piani orizzontali
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        session.run(configuration)
    }
}
