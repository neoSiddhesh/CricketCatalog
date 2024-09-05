//
//  TeamViewModel.swift
//  CricketCatalogSwiftUI
//
//  Created by Siddhesh Jadhav on 04/09/24.
//

import Foundation

class TeamViewModel: ObservableObject {
    
    private let repository: TeamsRepositoryProtocol
    @Published var teamPlayersData: Teams?
    @Published var filteredTeam: [Player]? = []
    @Published var searchText: String = ""
    @Published var selectedIndex: Int = 0
    @Published var showBottomSheet: Bool = false
    @Published var error: String = ""
    
    init(repository: TeamsRepositoryProtocol = TeamsRepository()) {
        self.repository = repository
    }
    
    func getTeamsData() {
        let result = repository.getTeamsData()
        switch result {
        case .success(let response):
            teamPlayersData = response
        case .failure(let error):
            self.error = error.localizedDescription
        }
    }
    
    func filterTeamPlayers(index: Int) {
        guard let team = teamPlayersData?.teams?[index] else {
            filteredTeam = []
            return
        }
        if searchText.isEmpty {
            filteredTeam = team.players ?? []
        } else {
            filteredTeam = team.players?.filter { player in
                player.name?.localizedCaseInsensitiveContains(searchText.lowercased()) ?? false
            } ?? []
        }
    }
}


