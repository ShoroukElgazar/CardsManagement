//
//  CreditCardValidationType.swift
//  CardsManagement
//
//  Created by Mac on 06/07/2023.
//

import Foundation

enum CardType: String {
    case Unknown, Meeza, Visa, MasterCard

    static let allCards = [Meeza, Visa, MasterCard]
    var regex : String {
        switch self {
        case .Meeza:
          return  "^5078(03|09|10|11)\\d{10}$"
        case .Visa:
           return "^4[0-9]{6,}([0-9]{3})?$"
        case .MasterCard:
           return "^(5[1-5][0-9]{4}|677189)[0-9]{5,}$"
        default:
           return ""
        }
    }

    func loadIcon() -> String{
        switch self {
        case .Meeza:
            return "meeza"
        case .Visa:
            return "visa"
        case .MasterCard:
            return "mastercard"
        case .Unknown:
            return "visa"
        }
    }
}
public struct CreditCardValidationType {
    
    func getCardType(cardNumber: String) -> CardType {
        var type: CardType = .Unknown
        for card in CardType.allCards {
            if matchesRegex(regex: card.regex, text: cardNumber) {
                type = card
                break
            }
        }
        
        return type
    }
    
    private func matchesRegex(regex: String, text: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            let range = NSRange(location: 0, length: text.utf16.count)
            let matches = regex.matches(in: text, options: [], range: range)
            return matches.count > 0
        } catch {
            return false
        }
    }
}
