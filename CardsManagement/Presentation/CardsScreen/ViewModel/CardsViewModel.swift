//
//  CardsViewModel.swift
//  CardsManagement
//
//  Created by Mac on 02/07/2023.
//

import Combine

class CardsViewModel: ObservableObject {
    var cardsListUseCase : DefaultCardsListUseCase
    var rechargeCardUseCase : DefaultRechargeCardUseCase
    @Published var cards: [Card] = []
    @Published var error : String = ""
    @Published var showValidationError  = false
    
    init(cardsListUseCase: DefaultCardsListUseCase,rechargeCardUseCase : DefaultRechargeCardUseCase) {
        self.cardsListUseCase = cardsListUseCase
        self.rechargeCardUseCase = rechargeCardUseCase
        loadCards()
    }
    
    func loadCards() {
        do{
            cards = try cardsListUseCase.getAllCards() ?? []
        } catch {
            print(error)
        }
    }
    
    func rechargeCard(id: String, newAmount: String) {
        do{
            let amount =  Double(newAmount)
            guard let amount = amount else {
                return
            }
            if amount >= 10 && amount < 10000 {
                try rechargeCardUseCase.rechargeCard(id: id, newAmount: String(amount))
                loadCards()
                showValidationError = false
            }
            else{
                self.error = "Amount should be greater than 10 and less than 10000"
                showValidationError = true
            }
        } catch {
            self.error = error.localizedDescription
        }
    }
}
