//
//  DeleteCardUseCase.swift
//  CardsManagement
//
//  Created by Mac on 05/07/2023.
//

import Foundation

class DeleteCardUseCase: DefaultDeleteCardUseCase {
    
    @Inject private var repo : DefaultCardsManagementRepository
    
    func deleteCard(id: String) async throws {
        try await repo.deleteCard(id: id)
    }
    
    func deleteAllCards() async throws {
        try await repo.deleteAllCards()
    }

}
