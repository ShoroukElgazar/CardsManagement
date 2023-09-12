//
//  AddCardViewModel.swift
//  CardsManagement
//
//  Created by Mac on 05/07/2023.
//

import Combine
import Foundation

class AddCardViewModel: ObservableObject {
    @Inject var addCardUseCase : DefaultAddCardUseCase
    var creditCardValidationType : CreditCardValidationType = CreditCardValidationType()
    func addCard(card: Card) async throws {
        try await addCardUseCase.saveCard(card: card)
    }

}

