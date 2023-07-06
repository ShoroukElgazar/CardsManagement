//
//  CardsManagementDataSrc.swift
//  CardsManagement
//
//  Created by Mac on 02/07/2023.
//

import Foundation


import Foundation

protocol DefaultCardsManagementDataSrc {
    func getAllCards() throws -> [CardDTO]?
    func saveCard(card: CardDTO) throws
    func updateCardAmount(id: String, newAmount: String) throws
    func deleteCard(id: String) throws
    func deleteAllCards() throws
}


class CardsManagementLocalDataSrc: DefaultCardsManagementDataSrc{
    var storage =  Storage.sharedInstance()
    
    func getAllCards() throws -> [CardDTO]? {
        try storage.getAllCards()
    }
    
    func saveCard(card: CardDTO) throws {
        try storage.save(card: card)
    }
    
    func deleteCard(id: String) throws {
        try storage.delete(id: id)
    }
    
    func deleteAllCards() throws {
        try storage.deleteAllCards()
    }
    
    func updateCardAmount(id: String, newAmount: String) throws {
        try storage.updateCardAmount(id: id, newAmount: newAmount)
    }
        
}

