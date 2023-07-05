//
//  CardsManagementViewModel.swift
//  CardsManagement
//
//  Created by Mac on 02/07/2023.
//

import Combine

class CardsManagementViewModel: ObservableObject {
    var cardsManagmentUseCase : CardsManagmentUseCase
    @Published var cards: [Card] = []
    init(cardsManagmentUseCase: CardsManagmentUseCase) {
        self.cardsManagmentUseCase = cardsManagmentUseCase
        loadCards()
    }
    
    func loadCards() {
        do{
            cards = try cardsManagmentUseCase.getAllCards() ?? []
        } catch {
            print(error)
        }
    }
    
}
