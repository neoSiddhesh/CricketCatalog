//
//  CricketCatalogSwiftUIApp.swift
//  CricketCatalogSwiftUI
//
//  Created by Siddhesh Jadhav on 04/09/24.
//

import SwiftUI

@main
struct CricketCatalogSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                TeamsView()
                    .preferredColorScheme(.light)
                    .background(.lightGreen)
            }
        }
    }
}
