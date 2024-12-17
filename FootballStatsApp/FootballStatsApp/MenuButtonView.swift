//
//  MenuButtonView.swift
//  FootballStatsApp
//
//  Created by Filippo Caliendo on 17/12/24.
//

import SwiftUICore
import SwiftUI

struct MenuButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Text(title)
                    .foregroundColor(isSelected ? .white : Color("pinkOpaque"))
                    .fontWeight(isSelected ? .bold : .regular)
                
                // Linea bianca sotto la voce selezionata
                if isSelected {
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 2)
                        .padding(.horizontal, 5)
                } else {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 2)
                }
            }
        }
        .animation(.easeInOut, value: isSelected) // Animazione per cambio stato
    }
}

