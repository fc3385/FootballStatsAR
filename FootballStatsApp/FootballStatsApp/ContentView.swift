//
//  ContentView.swift
//  FootballStatsApp
//
//  Created by Filippo Caliendo on 11/12/24.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Soccer Stats in AR")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                Spacer()

                NavigationLink(destination: ARViewContainer()) {
                    Text("Visualizza Statistiche in AR")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Spacer()
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    ContentView()
}
