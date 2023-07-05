//
//  CardsManagmentUseCase.swift
//  CardsManagement
//
//  Created by Mac on 05/07/2023.
//

import Foundation

class CardsListUseCase: DefaultCardsListUseCase {
    
    private var repo : DefaultCardsManagementRepository
    
    init(repo: DefaultCardsManagementRepository) {
        self.repo = repo
    }
    
    func getAllCards() throws -> [Card]? {
        try repo.getAllCards()
    }
 
}