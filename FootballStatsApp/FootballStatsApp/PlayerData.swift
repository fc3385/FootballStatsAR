//
//  PlayerData.swift
//  FootballStatsApp
//
//  Created by Filippo Caliendo on 11/12/24.
//

import Foundation


struct Player: Identifiable {
    let id = UUID()
    let name: String
    let role: String
    let image: String
}

struct TeamPlayers {
    static let liverpoolPlayers = [
        Player(name: "Alisson Becker", role: "GK", image: "salah"),
        Player(name: "Trent Alexander-Arnold", role: "RB", image: "salah"),
        Player(name: "Virgil van Dijk", role: "CB", image: "salah"),
        Player(name: "Joel Matip", role: "CB", image: "salah"),
        Player(name: "Andrew Robertson", role: "LB", image: "salah"),
        Player(name: "Fabinho", role: "CDM", image: "salah"),
        Player(name: "Jordan Henderson", role: "CM", image: "salah"),
        Player(name: "Thiago Alcântara", role: "CM", image: "salah"),
        Player(name: "Mohamed Salah", role: "RW", image: "salah"),
        Player(name: "Sadio Mané", role: "LW", image: "salah"),
        Player(name: "Roberto Firmino", role: "ST", image: "salah")
    ]
    
    static let tottenhamPlayers = [
        Player(name: "Hugo Lloris", role: "GK", image: "salah"),
        Player(name: "Emerson Royal", role: "RB", image: "salah"),
        Player(name: "Cristian Romero", role: "CB", image: "salah"),
        Player(name: "Eric Dier", role: "CB", image: "salah"),
        Player(name: "Ben Davies", role: "LB", image: "salah"),
        Player(name: "Pierre-Emile Højbjerg", role: "CDM", image: "salah"),
        Player(name: "Rodrigo Bentancur", role: "CM", image: "salah"),
        Player(name: "Dejan Kulusevski", role: "RW", image: "salah"),
        Player(name: "Heung-min Son", role: "LW", image: "salah"),
        Player(name: "Richarlison", role: "ST", image: "salah"),
        Player(name: "Harry Kane", role: "ST", image: "salah")
    ]
}
