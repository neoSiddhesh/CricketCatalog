//
//  BotttomSheetViewModel.swift
//  CricketCatalogUIKit
//
//  Created by Siddhesh Jadhav on 04/09/24.
//

import Foundation

protocol BottomSheetViewModelProtocol {
    var player: [Player] { get set }
    func topThreeCharacters() -> BottomSheetModel
    func getCharacterCountString(result: CharacterOccurrenceData) -> String
}

final class BottomSheetViewModel: BottomSheetViewModelProtocol {
    var player: [Player] = []
    
    func topThreeCharacters() -> BottomSheetModel {
        let allCharacters = player
            .compactMap{ $0.name }
            .joined()
        var charCount: [Character: Int] = [:]
        for char in allCharacters where char != " " {
            charCount[char, default: 0] += 1
        }
        let sortedCharCount = charCount.sorted { $0.value > $1.value }
        let topThree = sortedCharCount.prefix(3).map { CharacterOccurrenceData(character: String($0.key), count: $0.value) }
        let bottomSheetData = BottomSheetModel(characterOccurence: topThree)
        return bottomSheetData
    }
    
    func getCharacterCountString(result: CharacterOccurrenceData) -> String {
        return "\(result.character?.capitalized ?? "") = \(result.count ?? 0)"
    }
}
