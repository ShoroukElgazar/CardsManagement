//
//  CardDTO.swift
//  CardsManagement
//
//  Created by Mac on 03/07/2023.
//

import Foundation
import RealmSwift

class CardDTO : Object {
    @objc dynamic var id : String = UUID().uuidString
    @objc dynamic var cardHolder : String = ""
    @objc dynamic var cardNumber : String = ""
    @objc dynamic var cvv : String = ""
    @objc dynamic var expiryDate : String = ""
    @objc dynamic var amount : String = ""
    @objc dynamic var cardType: String = ""
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
