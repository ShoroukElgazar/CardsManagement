//
//  CardsManagementRepo.swift
//  CardsManagement
//
//  Created by Mac on 02/07/2023.
//

import Foundation

class CardsManagementRepo: DefaultCardsManagementRepository {
    
    let localDataSrc: DefaultCardsManagementDataSrc
    
    init(localDataSrc: DefaultCardsManagementDataSrc) {
        self.localDataSrc = localDataSrc
    }
    
    func getAllCards() throws -> [Card]? {
        var cardList : [Card] = []
        let cards = try localDataSrc.getAllCards()
        guard let items = cards else{
                return []
            }
            let list = items
            for card in list{
                cardList.append(card.toDomain())
            }
            return cardList
    }
    
    func saveCard(card: Card) throws {
        try localDataSrc.saveCard(card: toDTO(card: card))
    }
    
    func updateCardAmount(id: String, newAmount: String) throws {
        try localDataSrc.updateCardAmount(id: id, newAmount: newAmount)
    }
    
    func deleteCard(id: String) throws {
        try localDataSrc.deleteCard(id: id)
    }
    
    func deleteAllCards() throws {
        try localDataSrc.deleteAllCards()
    }
    
   private func toDTO(card: Card) -> CardDTO {
        let cardDTO = CardDTO()
        cardDTO.cardHolder = card.cardHolder
        cardDTO.cardNumber = card.cardNumber
        cardDTO.cvv = card.cvv
        cardDTO.expiryDate = card.expiryDate
        cardDTO.amount = card.amount
        cardDTO.cardType = card.cardType
           return cardDTO
       }
    
}
