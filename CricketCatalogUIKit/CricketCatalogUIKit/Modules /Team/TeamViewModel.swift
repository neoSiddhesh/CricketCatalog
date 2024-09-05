//
//  TeamViewModel.swift
//  CricketCatalogUIKit
//
//  Created by Siddhesh Jadhav on 04/09/24.
//

import Foundation

protocol TeamViewModelProtocol {
    var teams: [Team]  { get set }
    var filterTeamPlayers: [Player] { get set}
    var successBlock: (() -> Void)? { get set }
    var failureBlock: ((_ errorMessage: String) -> Void)? { get set }
    func didSearchPlayer(text: String)
    func getSelectedTeam() -> Team?
    func didCancelSearch()
    func updateSelectedTeam(index: Int)
    func fetchData()
}

final class TeamViewModel: TeamViewModelProtocol {
  
    private let repository: TeamsRepositoryProtocol = TeamsRepository()
    var teams: [Team] = []
    var successBlock: (() -> Void)?
    var failureBlock: ((_ errorMessage: String) -> Void)?
    private var selectedTeam: Team?
    var filterTeamPlayers: [Player] = []
    
    func getSelectedTeam() -> Team? {
        return selectedTeam
    }
    
    func didCancelSearch() {
        filterTeamPlayers = selectedTeam?.players ?? []
    }
    
    func updateSelectedTeam(index: Int) {
        selectedTeam = teams[index]
    }
    
    func didSearchPlayer(text: String) {
        let players = selectedTeam?.players ?? []
        filterTeamPlayers = text.isEmpty ? players : players.filter { ($0.name?.lowercased() ?? "").contains(text.lowercased()) }
        if filterTeamPlayers.isEmpty {
            failureBlock?(Constants.noDataFound)
        }
    }
    
    func fetchData() {
        let result = repository.getTeamsData()
        switch result {
        case .success(let teams) :
            self.teams = teams
            selectedTeam = teams.first
            filterTeamPlayers = teams.first?.players ?? []
            successBlock?()
        case .failure(let error) :
            failureBlock?(error.localizedDescription)
        }
    }
}

