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
                Circle().fill(Color.gray).frame(width: 8, height: 8)
                Circle().fill(Color.pink).frame(width: 8, height: 8)
                Circle().fill(Color.gray).frame(width: 8, height: 8)
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
    var players: [Player]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(players) { player in
                    HStack(spacing: 15) {
                        Image(player.image)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                        Text(player.name)
                            .font(.caption)
                            .fontWeight(.bold)
                        Text(player.role)
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
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
