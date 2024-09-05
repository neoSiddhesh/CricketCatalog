//
//  BottomSheetModel.swift
//  CricketCatalogSwiftUI
//
//  Created by Siddhesh Jadhav on 04/09/24.
//

import Foundation

struct BottomSheetModel {
    let characterOccurence: [CharacterOccurrenceData]?
}

struct CharacterOccurrenceData: Hashable {
    let character: String?
    let count: Int?
}

