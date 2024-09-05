//
//  TeamsView.swift
//  CricketCatalogSwiftUI
//
//  Created by Siddhesh Jadhav on 04/09/24.
//

import SwiftUI

struct TeamsView: View {
    
    @StateObject var viewModel: TeamViewModel = TeamViewModel()
    
    var body: some View {
        if viewModel.error.isEmpty {
            ZStack(alignment: .bottomTrailing) {
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
                        CountryFlagsView(selectedIndex: $viewModel.selectedIndex,
                                         teamPlayersData: $viewModel.teamPlayersData)
                        Section(header: SearchBarView(searchText: $viewModel.searchText)) {
                            PlayersListView(selectedIndex: $viewModel.selectedIndex,
                                            searchText: $viewModel.searchText,
                                            filteredTeam: $viewModel.filteredTeam)
                        }
                    }
                    .padding(2)
                }
                .safeAreaPadding(EdgeInsets(.zero))
                FloatingButtonView(showBottomSheet: $viewModel.showBottomSheet)
            }
            .sheet(isPresented: $viewModel.showBottomSheet) {
                BottomSheetView(selectedIndex: $viewModel.selectedIndex,
                                teamPlayersData: viewModel.teamPlayersData)
                    .presentationDetents([.height(200)])
            }
            .onAppear {
                viewModel.getTeamsData()
            }
            .onAppear {
                filterPlayers()
            }
            .onChange(of: viewModel.searchText) {
                filterPlayers()
            }
            .onChange(of: viewModel.selectedIndex) {
                viewModel.searchText = ""
                filterPlayers()
            }
        } else {
            Text(viewModel.error)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding([.leading, .trailing], 20)
        }
    }
    
    private func filterPlayers() {
        viewModel.filterTeamPlayers(index: viewModel.selectedIndex)
    }
}

