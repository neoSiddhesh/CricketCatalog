//
//  CountryFlagsView.swift
//  CricketCatalogSwiftUI
//
//  Created by Siddhesh Jadhav on 04/09/24.
//

import SwiftUI

struct CountryFlagsView: View {
    
    @Binding var selectedIndex: Int
    @Binding var teamPlayersData: Teams?
    
    var body: some View {
        ZStack(alignment: .top) {
            TabView(selection: $selectedIndex) {
                ForEach(0..<(teamPlayersData?.teams?.count ?? 0), id: \.self) { index in
                    if let imageName = teamPlayersData?.teams?[index].teamImageURL {
                        loadImage(named: imageName)
                            .tag(index)
                    }
                }
            }
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .tabViewStyle(.page)
            .frame(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.height*0.28)
            .animation(.easeIn, value: selectedIndex)
        }
        .navigationBarTitle(Text(teamPlayersData?.teams?[selectedIndex].country ?? ""))
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func loadImage(named imageName: String) -> some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(.bottom, 45)
            .frame(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.height*0.25)
            .cornerRadius(15.0)
    }
}
