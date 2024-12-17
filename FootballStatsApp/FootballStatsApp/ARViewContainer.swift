//
//  ARViewContainer.swift
//  FootballStatsApp
//
//  Created by Filippo Caliendo on 12/12/24.
//

import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: View {
    @State private var isModelPlaced = false // Stato per controllare se il modello è stato posizionato

    var body: some View {
        ZStack {
            // Passa il binding a 'isModelPlaced' al costruttore di ARViewRepresentable
            ARViewRepresentable(isModelPlaced: $isModelPlaced)
                .edgesIgnoringSafeArea(.all)

            if !isModelPlaced {
                Text("Touch where you want to put your model")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                    .padding()
            }

            VStack {
                Spacer()
                HeatMapCard()
            }
        }
    }
}
