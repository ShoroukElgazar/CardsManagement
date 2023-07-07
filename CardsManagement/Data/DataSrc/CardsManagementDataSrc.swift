//
//  CardsManagementDataSrc.swift
//  CardsManagement
//
//  Created by Mac on 02/07/2023.
//

import Foundation

protocol DefaultCardsManagementDataSrc {
    func getAllCards() async throws -> [CardDTO]?
    func saveCard(card: CardDTO) async throws
    func updateCardAmount(id: String, newAmount: String) async throws
    func deleteCard(id: String) async throws
    func deleteAllCards() async throws
}

class CardsManagementRemoteDataSrc: DefaultCardsManagementDataSrc {
    public let apiService: CardsAPIProvider

    init(apiService: CardsAPIProvider = CardsAPIProvider.create() ) {
        self.apiService = apiService
    }

       
    func getAllCards() async throws -> [CardDTO]? {
        let cards : [CardDTO] = try await apiService.request(target: .cards)
        return cards
    }

    func saveCard(card: CardDTO) async throws {
        let _ : Bool =  try await apiService.request(target: .saveCard(card: card))
    }
    

    func deleteCard(id: String) async throws {
        let _ : Bool = try await apiService.request(target: .deleteCard(id: id))
    }

    func deleteAllCards() async throws {
        let _ : Bool = try await apiService.request(target: .deleteAllCards)
    }

    func updateCardAmount(id: String, newAmount: String) async throws {
        let _ : Bool = try await apiService.request(target: .updateCardAmount(id: id, amount: newAmount))
    }

}

class CardsManagementLocalDataSrc: DefaultCardsManagementDataSrc{
    @Inject private var storage : Storage

    func getAllCards() async throws -> [CardDTO]? {
         try await storage.getAllCards()
    }
    
    func saveCard(card: CardDTO) async throws {
        try await storage.save(card: card)
    }
    
    func deleteCard(id: String) async throws {
        try await storage.delete(id: id)
    }
    
    func deleteAllCards() async throws {
        try await storage.deleteAllCards()
    }
    
    func updateCardAmount(id: String, newAmount: String) async throws {
        try await storage.updateCardAmount(id: id, newAmount: newAmount)
    }
        
}

