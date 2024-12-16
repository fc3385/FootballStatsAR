//
//  PlayerSelectionVIew.swift
//  FootballStatsApp
//
//  Created by Filippo Caliendo on 16/12/24.
//

import SwiftUI

struct PlayerSelectionView: View {
    @Binding var selectedPlayer: Player // Riferimento al giocatore selezionato (stato condiviso)
    var player: Player // Informazioni sul giocatore corrente

    var body: some View {
        HStack(spacing: 15) {
            Image(player.image)
                .resizable()
                .frame(width: 30, height: 30)
                .clipShape(Circle())
            Text(player.name)
                .font(.caption)
                .fontWeight(selectedPlayer.id == player.id ? .bold : .medium)
                .foregroundColor(selectedPlayer.id == player.id ? Color.accentColor : Color.black)
            Text(player.role)
                .font(.caption2)
                .foregroundColor(.white)
                .fontWeight(.semibold)
        }
        .padding()
        .background(selectedPlayer.id == player.id ? Color.pinkOpaque : Color.grayBackground) // Evidenzia se selezionato
        .cornerRadius(10)
        .onTapGesture {
            selectedPlayer = player // Aggiorna il giocatore selezionato
        }
    }
}

struct PlayerCarousel_Previews: PreviewProvider {
    static var previews: some View {
        PlayerCarousel(players: TeamPlayers.liverpoolPlayers)
    }
}
