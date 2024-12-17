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
        selectedTeam == "Liverpool" ? TeamPlayers.liverpoolPlayers : TeamPlayers.tottenhamPlayers
    }

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundStyle(Color.accentColor)
                HStack {
                    Spacer()
                    Text("3")
                        .font(
                            .system(size: 175, weight: .bold, design: .default)
                        )
                        .foregroundColor(Color.white)
                        .padding()
                    Rectangle()
                        .foregroundStyle(Color.white)
                        .frame(width: 32, height: 14)
                        .padding()
                    Text("3")
                        .font(
                            .system(size: 175, weight: .bold, design: .default)
                        )
                        .foregroundColor(Color.white)
                        .padding()
                    Spacer()
                }
                HStack {
                    Spacer()
                    VStack {
                        Image("LiverpoolNS")
                        Text("Liverpool")
                            .font(.headline)
                    }
                    .padding(.top, 50.0)
                    Spacer()
                        .frame(minWidth: 0, maxWidth: 50)
                    VStack {
                        Image("TottenhamNS")
                        Text("Tottenham")
                            .font(.headline)
                    }
                    .padding(.top, 50.0)
                    Spacer()
                }

                HStack(spacing: 30) {
                        MenuButton(title: MenuItem.lineups.rawValue,
                                   isSelected: selectedMenu == .lineups) {
                            selectedMenu = .lineups
                        }
                        
                        MenuButton(title: MenuItem.heatMaps.rawValue,
                                   isSelected: selectedMenu == .heatMaps) {
                            selectedMenu = .heatMaps
                        }
                        
                        MenuButton(title: MenuItem.shots.rawValue,
                                   isSelected: selectedMenu == .shots) {
                            selectedMenu = .shots
                        }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    .frame(maxHeight: .infinity, alignment: .bottom)

            }
            .frame(height: 320)
            VStack(spacing: 10) {
                Picker("Seleziona la squadra", selection: $selectedTeam) {
                    Text("Liverpool").tag("Liverpool")
                    Text("Tottenham").tag("Tottenham")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                PlayerCarousel(players: players)
            }
            .padding(.top, 10)
            
            Spacer()

        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
