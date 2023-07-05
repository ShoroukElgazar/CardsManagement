//
//  CardsManagementViewModel.swift
//  CardsManagement
//
//  Created by Mac on 02/07/2023.
//

import Combine

class CardsManagementViewModel: ObservableObject {
    var cardsListUseCase : DefaultCardsListUseCase
    @Published var cards: [Card] = []
    init(cardsListUseCase: DefaultCardsListUseCase) {
        self.cardsListUseCase = cardsListUseCase
        loadCards()
    }
    
    func loadCards() {
        do{
            cards = try cardsListUseCase.getAllCards() ?? []
        } catch {
            print(error)
        }
    }
    
}
