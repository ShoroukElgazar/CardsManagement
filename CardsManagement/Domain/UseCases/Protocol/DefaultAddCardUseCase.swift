//
//  DefaultAddCardUseCase.swift
//  CardsManagement
//
//  Created by Mac on 05/07/2023.
//

import Foundation

protocol DefaultAddCardUseCase {
    func saveCard(card: Card) async throws
}
