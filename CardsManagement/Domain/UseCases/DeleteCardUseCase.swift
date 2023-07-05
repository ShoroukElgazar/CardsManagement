//
//  DeleteCardUseCase.swift
//  CardsManagement
//
//  Created by Mac on 05/07/2023.
//

import Foundation

class DeleteCardUseCase: DefaultDeleteCardUseCase {
    
    private var repo : DefaultCardsManagementRepository
    
    init(repo: DefaultCardsManagementRepository) {
        self.repo = repo
    }
    
    func deleteCard(id: String) throws {
        try repo.deleteCard(id: id)
    }
    
    func deleteAllCards() throws {
        try repo.deleteAllCards()
    }

}
