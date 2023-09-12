//
//  CardsManagmentUseCase.swift
//  CardsManagement
//
//  Created by Mac on 05/07/2023.
//

import Foundation

class CardsListUseCase: DefaultCardsListUseCase {
    
    @Inject private var repo : DefaultCardsManagementRepository
  
    func getAllCards() async throws -> [Card]? {
        try await repo.getAllCards()
    }
 
}
