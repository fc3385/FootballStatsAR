//
//  HeatMapCard.swift
//  FootballStatsApp
//
//  Created by Filippo Caliendo on 11/12/24.
//

import SwiftUI

struct TeamStatView: View {
    var teamName: String
    var logo: String

    var body: some View {
        VStack {
            Image(logo)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            Text(teamName)
                .font(.caption)
                .multilineTextAlignment(.center)
        }
    }
}


struct HeatMapCard: View {
    @State private var selectedTeam = "Liverpool"
    
    
    var players: [Player] {
        selectedTeam == "Liverpool" ? TeamPlayers.liverpoolPlayers : TeamPlayers.tottenhamPlayers
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Heat Maps")
                .font(.headline)
                .fontWeight(.bold)
            
            Picker("Seleziona la squadra", selection: $selectedTeam) {
                Text("Liverpool").tag("Liverpool")
                Text("Tottenham").tag("Tottenham")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            PlayerCarousel(players: players)
                        
            HStack(spacing: 8) {
                Circle().fill(Color.pinkOpaque).frame(width: 8, height: 8)
                Circle().fill(Color.accentColor).frame(width: 8, height: 8)
                Circle().fill(Color.pinkOpaque).frame(width: 8, height: 8)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white)
                .shadow(radius: 10)
        )
        .padding(.horizontal)
    }
}


struct PlayerCarousel: View {
    @State private var selectedPlayer: Player = TeamPlayers.liverpoolPlayers[0] // Giocatore selezionato iniziale
    var players: [Player] // Lista dei giocatori disponibili

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(players) { player in
                        PlayerSelectionView(selectedPlayer: $selectedPlayer, player: player)
                    }
                }
            }
        }
    }
}

struct HeatMapCard_Previews: PreviewProvider {
    static var previews: some View {
        HeatMapCard()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.gray.opacity(0.2))
    }
}
