//
//  BottomSheetView.swift
//  CricketCatalogSwiftUI
//
//  Created by Siddhesh Jadhav on 04/09/24.
//

import SwiftUI

struct BottomSheetView: View {
    
    @StateObject var viewModel: BottomSheetViewModel = BottomSheetViewModel()
    @State var dict: [CharacterOccurrenceData] = []
    @Binding var selectedIndex: Int
    var teamPlayersData: Teams?
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    Section(header: sectionHeader) {
                        ForEach(dict, id: \.self) { model in
                            VStack(alignment: .leading, spacing: 0) {
                                Text("\(model.character ?? "") = \(model.count ?? 0)")
                                    .font(.callout)
                                    .foregroundColor(Color(.darkGray))
                                    .textCase(.uppercase)
                                    .padding(.bottom, 5)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.leading, .trailing], 25)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .background(.white)
            .onAppear {
                loadCharacterData()
            }
        }
    }
    
    private var sectionHeader: some View {
        VStack {
            Capsule()
                .fill(Color.gray)
                .frame(width: 40, height: 6)
                .padding(.top, 8)
                .padding(.bottom, -8)
            Text("Player Count (\(teamPlayersData?.teams?[selectedIndex].players?.count ?? 0))")
                .font(.callout)
                .bold()
                .foregroundColor(.black)
                .padding(.vertical, 7)
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(.white)
        }
    }
    
    private func loadCharacterData() {
        let playersData: [Player] = teamPlayersData?.teams?[selectedIndex].players ?? []
        dict = viewModel.topThreeCharacters(in: playersData.map { $0.name ?? "" }).characterOccurence ?? []
    }
}

