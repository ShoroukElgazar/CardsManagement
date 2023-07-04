//
//  Card.swift
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
    @objc dynamic var cvv : Int = 0
    @objc dynamic var expiryDate : String = ""
}

// MARK: - Mappings to Domain
extension CardDTO {
    func toDomain() -> Card {
        let cardHolder = cardHolder
        let cardNumber = cardNumber
        let cvv = cvv
        let expiryDate = expiryDate
        let id = id
        
        return Card(id: id,cardHolder: cardHolder,cardNumber: cardNumber,cvv: cvv,expiryDate: expiryDate)
    }
}
