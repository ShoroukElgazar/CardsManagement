//
//  CardDTO.swift
//  CardsManagement
//
//  Created by Mac on 03/07/2023.
//

import Foundation
import RealmSwift

class CardDTO : Object, Identifiable {
    @Persisted(primaryKey: true) var id : String = UUID().uuidString
    @Persisted var cardHolder : String = ""
    @Persisted var cardNumber : String = ""
    @Persisted var cvv : String = ""
    @Persisted var expiryDate : String = ""
    @Persisted var amount : String = ""
    @Persisted var cardType: String = ""
}

// MARK: - Mappings to Domain
extension CardDTO {
    func toDomain() -> Card {
        let id = id
        let cardHolder = cardHolder
        let cardNumber = cardNumber
        let cvv = cvv
        let expiryDate = expiryDate
        let cardType = cardType
        
        return Card(id: id,cardHolder: cardHolder,cardNumber: cardNumber,cvv: cvv,expiryDate: expiryDate,amount: amount,cardType: cardType)
    }
}
