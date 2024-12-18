//
//  ContentView.swift
//  FootballStatsApp
//
//  Created by Filippo Caliendo on 11/12/24.
//

import RealityKit
import SwiftUI

struct ContentView: View {

    enum MenuItem: String {
        case lineups = "Lineups"
        case heatMaps = "Heat maps"
        case shots = "Shots"
    }

    @State private var selectedMenu: MenuItem = .heatMaps
    @State private var selectedTeam = "Liverpool"

    var players: [Player] {
        selectedTeam == "Liverpool"
            ? TeamPlayers.liverpoolPlayers : TeamPlayers.tottenhamPlayers
    }

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .foregroundStyle(Color.accentColor)
                    HStack {
                        Spacer()
                        Text("3")
                            .font(
                                .system(
                                    size: 175, weight: .bold, design: .default)
                            )
                            .foregroundColor(Color.white)
                            .padding()
                            .accessibilityLabel("3")
                            .accessibilityHint("Home Team Score")
                        Rectangle()
                            .foregroundStyle(Color.white)
                            .frame(width: 32, height: 14)
                            .padding()
                            .accessibilityHidden(true)
                        Text("3")
                            .font(
                                .system(
                                    size: 175, weight: .bold, design: .default)
                            )
                            .foregroundColor(Color.white)
                            .padding()
                            .accessibilityLabel("3")
                            .accessibilityHint("Away Team Score")
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        VStack {
                            Image("LiverpoolNS")
                                .accessibilityHidden(true)
                            Text("Liverpool")
                                .font(.headline)
                                .accessibilityLabel("Liverpool, Home")
                                .accessibilityHint("Home Team")
                        }
                        .padding(.top, 50.0)
                        Spacer()
                            .frame(minWidth: 0, maxWidth: 50)
                        VStack {
                            Image("TottenhamNS")
                                .accessibilityHidden(true)
                            Text("Tottenham")
                                .font(.headline)
                                .accessibilityLabel("Tottenham, Away")
                                .accessibilityHint("Away Team")
                        }
                        .padding(.top, 50.0)
                        Spacer()
                    }

                    HStack(spacing: 30) {
                        MenuButton(
                            title: MenuItem.lineups.rawValue,
                            isSelected: selectedMenu == .lineups
                        ) {
                            selectedMenu = .lineups
                        }
                        .accessibilityLabel("Lineups")
                        .accessibilityHint("Click this button to have access to Lineups")

                        MenuButton(
                            title: MenuItem.heatMaps.rawValue,
                            isSelected: selectedMenu == .heatMaps
                        ) {
                            selectedMenu = .heatMaps
                        }
                        .accessibilityLabel("Heat maps")
                        .accessibilityHint("Click this button to have access to Heat Maps")

                        MenuButton(
                            title: MenuItem.shots.rawValue,
                            isSelected: selectedMenu == .shots
                        ) {
                            selectedMenu = .shots
                        }
                        .accessibilityLabel("Shots")
                        .accessibilityHint("Click this button to have access to Shot statistics")
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    .frame(maxHeight: .infinity, alignment: .bottom)

                }
                .ignoresSafeArea()
                .frame(height: 280)
                VStack(spacing: 15) {
                    Picker("Seleziona la squadra", selection: $selectedTeam) {
                        Text("Liverpool").tag("Liverpool")
                        Text("Tottenham").tag("Tottenham")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)

                    PlayerCarousel(players: players)
                }
                .padding(.top, 10)

                Image("heatmap")
                    .resizable()
                    .rotationEffect(.degrees(90))
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .accessibilityLabel("Selected player Heatmap")

                NavigationLink(destination: ARViewContainer()) {
                    Text("View in AR       ")
                        .font(.title2)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .accessibilityLabel("View in AR")
                .accessibilityHint("Click twice to open AR View")
                
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
