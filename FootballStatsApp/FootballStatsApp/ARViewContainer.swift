//
//  ARViewContainer.swift
//  FootballStatsApp
//
//  Created by Filippo Caliendo on 12/12/24.
//


import SwiftUI
import RealityKit

struct ARViewContainer: View {
    var body: some View {
        ZStack {
            ARViewRepresentable()
                .edgesIgnoringSafeArea(.all)


            VStack {
                Spacer()
                HeatMapCard()
            }
        }
    }
}

