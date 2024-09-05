//
//  SearchBarView.swift
//  CricketCatalogSwiftUI
//
//  Created by Siddhesh Jadhav on 04/09/24.
//

import SwiftUI

struct SearchBarView: View {
    
    @State private var isEditing = false
    @Binding var searchText: String
    
    var body: some View {
        VStack {
            HStack {
                searchField
                if isEditing {
                    cancelButton
                }
            }
            .padding([.leading,.trailing], 20)
            .padding([.top,.bottom], 10)
            .background(.lightGreen)
        }
    }
    
    private var searchField: some View {
        HStack {
            Image(systemName: ImageConstants.search.rawValue)
                .foregroundColor(.gray)
                .padding(.leading, 10)
            
            ZStack(alignment: .leading) {
                if searchText.isEmpty {
                    Text(StringConstants.searchPlayer.rawValue)
                        .foregroundColor(.gray)
                }
                TextField(StringConstants.searchPlayer.rawValue, text: $searchText)
                    .padding(.vertical, 5)
                    .foregroundColor(.primary)
                    .onChange(of: searchText) {
                        if searchText.isEmpty {
                            isEditing = false
                        } else {
                            isEditing = true
                        }
                    }
            }
        }
        .background(Color(.systemGray5))
        .cornerRadius(10)
    }
    
    private var cancelButton: some View {
        Text("Cancel")
            .foregroundColor(.blue)
            .onTapGesture {
                searchText = ""
                hideKeyboard()
                isEditing = false
            }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


