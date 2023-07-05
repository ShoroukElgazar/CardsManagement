//
//  AddCardViewModel.swift
//  CardsManagement
//
//  Created by Mac on 05/07/2023.
//

import Combine

class AddCardViewModel: ObservableObject {
    var addCardUseCase : DefaultAddCardUseCase
    @Published var error : String? = nil
    
    init(addCardUseCase: DefaultAddCardUseCase) {
        self.addCardUseCase = addCardUseCase
    }
   
    func addCard(card: Card) {
        do{
            try addCardUseCase.saveCard(card: card)
        } catch {
        print(error)
        }
    }
    
}
