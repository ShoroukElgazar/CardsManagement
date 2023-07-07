//
//  DefaultCardsManagementRepository.swift
//  CardsManagement
//
//  Created by Mac on 05/07/2023.
//

import Foundation

protocol DefaultCardsManagementRepository {
    func getAllCards() async throws -> [Card]?
    func updateCardAmount(id: String, newAmount: String) async throws
    func saveCard(card: Card) async throws
    func deleteCard(id: String) async throws
    func deleteAllCards() async throws
}
