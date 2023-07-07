//
//  CardsAPI.swift
//  CardsManagement
//
//  Created by Mac on 07/07/2023.
//

import Foundation
import Moya


typealias CardsAPIProvider = MoyaProvider<CardsAPI>

enum CardsAPI {
    case cards
    case saveCard(card: CardDTO)
    case deleteCard(id: String)
    case deleteAllCards
    case updateCardAmount(id: String, amount: String)
}

extension CardsAPI: MoyaTargetType {

    var path: String {
        switch self {
        case .cards,.saveCard,.deleteCard,.deleteAllCards,.updateCardAmount: return ""
        }
    }

    var method: Moya.Method {
        switch self {
        case .cards: return .get
        case .saveCard,.deleteCard,.deleteAllCards,.updateCardAmount: return .post
            
        }
    }

    var task: Task {
        switch self {
        case .cards:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .saveCard,.deleteCard,.deleteAllCards,.updateCardAmount:
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .cards,.saveCard,.deleteCard,.deleteAllCards,.updateCardAmount:
            return [:]
        }
    }

}

