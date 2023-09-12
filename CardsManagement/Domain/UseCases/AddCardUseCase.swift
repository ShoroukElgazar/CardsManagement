//
//  AddCardUseCase.swift
//  CardsManagement
//
//  Created by Mac on 05/07/2023.
//

import Foundation

class AddCardUseCase: DefaultAddCardUseCase {
    @Inject private var repo : DefaultCardsManagementRepository
      
    func saveCard(card: Card) async throws {
        guard isCardHolderNameValid(name: card.cardHolder) else {
            throw "Invalid card holder"
        }
         
        guard isCardHolderNumberValid(cardNumber: card.cardNumber) else {
            throw "Invalid card number"
           }
        
        guard isCardCvvValid(cvv: card.cvv) else {
            throw "Invalid card CVV"
           }
        
        guard isCardExpiryDateValid(expiryDate: card.expiryDate) else {
            throw "Invalid card expiry date"
           }
           
        try await repo.saveCard(card: card)
       }
    
    func isCardHolderNameValid(name: String) -> Bool {
        return !name.isEmpty
    }
    
    func isCardHolderNumberValid(cardNumber: String) -> Bool {
        let numberRegex = #"^\d{16}$"#
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        return numberPredicate.evaluate(with: cardNumber)
    }
    
    func isCardCvvValid(cvv: String) -> Bool {
        let cvvRegex = #"^\d{3}$"#
        let cvvPredicate = NSPredicate(format: "SELF MATCHES %@", cvvRegex)
        return cvvPredicate.evaluate(with: cvv)
    }
    
    func isCardExpiryDateValid(expiryDate: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/yy"
        guard let expiryDate = dateFormatter.date(from: expiryDate) else {
            return false
        }
        let currentDate = Date()
        return expiryDate > currentDate
    }
}


