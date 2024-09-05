//
//  PlayerCellView.swift
//  CricketCatalogSwiftUI
//
//  Created by Siddhesh Jadhav on 04/09/24.
//

import SwiftUI

struct PlayerCellView: View {
    
    var playerName: String?
    var playerRole: String?
    
    var body: some View {
        VStack {
            HStack {
                Image(ImageConstants.noImage.rawValue)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 65, height: 65)
                    .cornerRadius(5)
                    .padding(.leading, 3)
                    .padding([.top, .bottom], 5)
                    .clipped()
                VStack(alignment: .leading, spacing: 8) {
                    Text(playerName ?? "")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 5)
                    Text(playerRole ?? "")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color(UIColor.darkGray))
                        .padding(.leading, 5)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.leading, .trailing], 10)
            .padding([.top, .bottom], 8)
        }
        .background(.darkGreen)
        .cornerRadius(20)
        .padding([.leading, .trailing], 20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.customGray, lineWidth: 1)
                .padding([.leading, .trailing], 20)
        )
    }
}

