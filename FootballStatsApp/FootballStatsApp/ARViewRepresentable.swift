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
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        arView.setupARSession()

        // Caricamento del modello generico "Experience"
        if let model = try? Entity.load(named: "Scene") {
            let anchor = AnchorEntity(world: [0, 0, -1]) // Posizionamento del modello
            anchor.addChild(model)
            arView.scene.anchors.append(anchor)
        } else {
            print("Errore: Impossibile caricare il modello 'Experience'")
        }

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        // Nessun aggiornamento dinamico richiesto
    }
}

extension ARView {
    func setupARSession() {
        // Configurazione dell'AR session (es. rilevamento di piani o tracking)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        session.run(configuration)
    }
}
