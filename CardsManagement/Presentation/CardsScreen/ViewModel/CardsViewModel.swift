//
//  CardsViewModel.swift
//  CardsManagement
//
//  Created by Mac on 02/07/2023.
//

import Combine

class CardsViewModel: ObservableObject {
    @Inject private var cardsListUseCase : DefaultCardsListUseCase
    @Inject private var rechargeCardUseCase : DefaultRechargeCardUseCase
    @Inject private var deleteCardUseCase : DefaultDeleteCardUseCase
    @Inject var addCardUseCase : DefaultAddCardUseCase
    var creditCardValidationType : CreditCardValidationType = CreditCardValidationType()

    
    @Published var cards: [Card] = []
    @Published var error : String = ""
    @Published var showValidationError  = false
    @Published var isLoading  = false
    
    
    func loadCards() async {
        do{
            cards = try await cardsListUseCase.getAllCards() ?? []
        } catch {
            print(error)
        }
        isLoading = false
    }
    
    func rechargeCard(id: String, newAmount: String) async {
        do{
            let amount =  Double(newAmount)
            guard let amount = amount else {
                return
            }
            if amount >= 10 && amount < 10000 {
                try await rechargeCardUseCase.rechargeCard(id: id, newAmount: String(amount))
                await loadCards()
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
    
    func deleteCard(id: String) async {
        do{
            try await deleteCardUseCase.deleteCard(id: id)
            await loadCards()
        } catch {
            print(error)
        }
    }
    
    func addCard(card: Card) async throws {
        try await addCardUseCase.saveCard(card: card)
        await loadCards()
    }
}
