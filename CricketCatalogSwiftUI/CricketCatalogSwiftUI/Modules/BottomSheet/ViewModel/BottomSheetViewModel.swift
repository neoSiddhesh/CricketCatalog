//
//  BottomSheetViewModel.swift
//  CricketCatalogSwiftUI
//
//  Created by Siddhesh Jadhav on 04/09/24.
//

import Foundation

class BottomSheetViewModel: ObservableObject {
    
    func topThreeCharacters(in array: [String]) -> BottomSheetModel {
        let allCharacters = array.joined()
        var charCount: [Character: Int] = [:]
        for char in allCharacters where char != " " {
            charCount[char, default: 0] += 1
        }
        let sortedCharCount = charCount.sorted { $0.value > $1.value }
        let topThree = sortedCharCount.prefix(3).map { CharacterOccurrenceData(character: String($0.key), count: $0.value) }
        let bottomSheetData = BottomSheetModel(characterOccurence: topThree)
        return bottomSheetData
    }
}

