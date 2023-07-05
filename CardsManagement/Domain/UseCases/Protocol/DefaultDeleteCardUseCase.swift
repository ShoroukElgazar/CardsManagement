//
//  DefaultDeleteCardUseCase.swift
//  CardsManagement
//
//  Created by Mac on 05/07/2023.
//

import Foundation

protocol DefaultDeleteCardUseCase {
    func deleteCard(id: String) throws
    func deleteAllCards() throws
}
