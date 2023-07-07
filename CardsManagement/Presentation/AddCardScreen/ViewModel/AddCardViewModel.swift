//
//  AddCardViewModel.swift
//  CardsManagement
//
//  Created by Mac on 05/07/2023.
//

import Combine
import Foundation

class AddCardViewModel: ObservableObject {
    var addCardUseCase : DefaultAddCardUseCase
    var creditCardValidationType : CreditCardValidationType = CreditCardValidationType()
    
    init(addCardUseCase: DefaultAddCardUseCase) {
        self.addCardUseCase = addCardUseCase
    }
   
    func addCard(card: Card) throws {
      try addCardUseCase.saveCard(card: card)
    }
    
 
}

