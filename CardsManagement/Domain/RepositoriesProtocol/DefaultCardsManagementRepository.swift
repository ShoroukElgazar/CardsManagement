//
//  DefaultCardsManagementRepository.swift
//  CardsManagement
//
//  Created by Mac on 05/07/2023.
//

import Foundation

protocol DefaultCardsManagementRepository {
    func getAllCards() throws -> [Card]?
    func updateCardAmount(id: String, newAmount: String) throws 
    func saveCard(card: Card) throws
    func deleteCard(id: String) throws
    func deleteAllCards() throws
}
