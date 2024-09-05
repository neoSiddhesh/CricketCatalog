//
//  PlayersListView.swift
//  CricketCatalogSwiftUI
//
//  Created by Siddhesh Jadhav on 04/09/24.
//

import SwiftUI

struct PlayersListView: View {
    
    @Binding var selectedIndex: Int
    @Binding var searchText: String
    @Binding var filteredTeam: [Player]?
    
    var body: some View {
        VStack {
            if filteredTeam?.count == 0 {
                Text(StringConstants.dataNotFound.rawValue)
                    .frame(height: 200)
            } else {
                ForEach(filteredTeam ?? [], id: \.self) { player in
                    PlayerCellView(playerName: player.name,
                                   playerRole: player.role)
                }
            }
        }
    }
}

