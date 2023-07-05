//
//  AddCardUseCase.swift
//  CardsManagement
//
//  Created by Mac on 05/07/2023.
//

import Foundation

class AddCardUseCase: DefaultAddCardUseCase {
    private var repo : DefaultCardsManagementRepository
    
    init(repo: DefaultCardsManagementRepository) {
        self.repo = repo
    }
    enum ValidationError: Error {
            case invalidCardHolderName
            case invalidCardHolderNumber
            case invalidCardCvv
            case invalidCardExpiryDate
        }
        
    func saveCard(card: Card) throws {
        guard isCardHolderNameValid(name: card.cardHolder) else {
            throw ValidationError.invalidCardHolderName
        }
         
        guard isCardHolderNumberValid(cardNumber: card.cardNumber) else {
               throw ValidationError.invalidCardHolderNumber
           }
        
        guard isCardCvvValid(cvv: card.cvv) else {
               throw ValidationError.invalidCardCvv
           }
        
        guard isCardExpiryDateValid(expiryDate: card.expiryDate) else {
               throw ValidationError.invalidCardExpiryDate
           }
           
           try repo.saveCard(card: card)
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
    
    //TODO: change this
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
