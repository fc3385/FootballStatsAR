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
        

        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        arView.session.run(configuration)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
    }
}
