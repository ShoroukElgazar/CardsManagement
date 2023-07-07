//
//  DefaultCardsListUseCase.swift
//  CardsManagement
//
//  Created by Mac on 05/07/2023.
//

import Foundation

protocol DefaultCardsListUseCase {
    func getAllCards() async throws -> [Card]?
}



