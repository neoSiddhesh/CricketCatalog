//
//  TeamsRepository.swift
//  CricketCatalogSwiftUI
//
//  Created by Siddhesh Jadhav on 04/09/24.
//

import Foundation

protocol TeamsRepositoryProtocol {
    func getTeamsData() -> Result<Teams, CustomError>
}

class TeamsRepository: TeamsRepositoryProtocol {
    private var fileReader: FileReaderProtocol
    
    init(fileReader: FileReaderProtocol = FileReader()) {
        self.fileReader = fileReader
    }
    
    func getTeamsData() -> Result<Teams, CustomError> {
        let result = fileReader.loadDataFrom(file: "CricketTeams", type: "json", decodingType: Teams.self)
        switch result {
        case .success(let response):
            return .success(response)
        case .failure(let error):
            return .failure(error)
        }
    }
}

