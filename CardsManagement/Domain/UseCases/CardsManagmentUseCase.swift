//
//  CardsManagmentUseCase.swift
//  CardsManagement
//
//  Created by Mac on 05/07/2023.
//

import Foundation

class CardsManagmentUseCase: DefaultCardsManagmentUseCase {
    
    private var repo : DefaultCardsManagementRepository
    
    init(repo: DefaultCardsManagementRepository) {
        self.repo = repo
    }
    
    func getAllCards() throws -> [Card]? {
        try repo.getAllCards()
    }
    
    func saveCard(card: Card) throws {
        try repo.saveCard(card: card)
    }
    
    func deleteCard(id: String) throws {
        try repo.deleteCard(id: id)
    }
    
    func deleteAllCards() throws {
        try repo.deleteAllCards()
    }
    

}
