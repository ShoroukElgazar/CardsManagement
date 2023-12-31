//
//  Card.swift
//  CardsManagement
//
//  Created by Mac on 03/07/2023.
//

import Foundation

struct Card: Identifiable {
   var id : String = UUID().uuidString
   var cardHolder : String = ""
   var cardNumber : String = ""
   var cvv : String = ""
   var expiryDate : String = ""
   var amount: String = "0.00"
   var cardType: CardType = .Unknown
}
