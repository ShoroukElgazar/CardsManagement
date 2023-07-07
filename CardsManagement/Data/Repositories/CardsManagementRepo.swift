//
//  CardsManagementRepo.swift
//  CardsManagement
//
//  Created by Mac on 02/07/2023.
//

import Foundation

class CardsManagementRepo: DefaultCardsManagementRepository {
    
    let localDataSrc: DefaultCardsManagementDataSrc
    let remoteDataSrc: DefaultCardsManagementDataSrc
    
    init(localDataSrc: DefaultCardsManagementDataSrc, remoteDataSrc: DefaultCardsManagementDataSrc) {
        self.localDataSrc = localDataSrc
        self.remoteDataSrc = remoteDataSrc
    }
    
    func getAllCards() async throws -> [Card]? {
        do {
            let cards = try await remoteDataSrc.getAllCards()
            if let items = cards {
                return items.map { $0.toDomain() }
            } else {
                return nil
            }
        } catch {
            let localCards = try await localDataSrc.getAllCards()
            if let items = localCards {
                return items.map { $0.toDomain() }
            } else {
                return nil
            }
        }
    }
    
    func saveCard(card: Card) async throws {
        if try await isCardNumberAlreadyExists(cardNumber: card.cardNumber) {
            throw("Card Number is already exist")
        }else{
            do {
                try await remoteDataSrc.saveCard(card: toDTO(card: card))
            } catch {
                try await localDataSrc.saveCard(card: toDTO(card: card))
            }
        }
    }
    
    func updateCardAmount(id: String, newAmount: String) async throws {
        do {
            try await remoteDataSrc.updateCardAmount(id: id, newAmount: newAmount)
        } catch {
            try await localDataSrc.updateCardAmount(id: id, newAmount: newAmount)
        }
    }
    
    func deleteCard(id: String) async throws {
        do {
            try await remoteDataSrc.deleteCard(id: id)
        } catch {
            try await localDataSrc.deleteCard(id: id)
        }
    }
    
    func deleteAllCards() async throws {
        do {
            try await remoteDataSrc.deleteAllCards()
        } catch {
            try await localDataSrc.deleteAllCards()
        }
    }
    
    private func toDTO(card: Card) -> CardDTO {
        let cardDTO = CardDTO()
        cardDTO.cardHolder = card.cardHolder
        cardDTO.cardNumber = card.cardNumber
        cardDTO.cvv = card.cvv
        cardDTO.expiryDate = card.expiryDate
        cardDTO.amount = card.amount
        cardDTO.cardType = card.cardType.rawValue
        return cardDTO
    }
    
    private func isCardNumberAlreadyExists(cardNumber: String) async throws -> Bool {
        do{
            let existingCards = try await remoteDataSrc.getAllCards()
            
            if let cards = existingCards {
                return cards.contains { $0.cardNumber == cardNumber }
            }
            return false
        }catch{
            let existingCards = try await localDataSrc.getAllCards()
            if let cards = existingCards {
                return cards.contains { $0.cardNumber == cardNumber }
            }
            return false
        }
    }
            
    
}
