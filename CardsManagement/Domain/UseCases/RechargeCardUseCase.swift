//
//  RechargeCardUseCase.swift
//  CardsManagement
//
//  Created by Mac on 06/07/2023.
//

import Foundation

class RechargeCardUseCase: DefaultRechargeCardUseCase {
    @Inject private var repo : DefaultCardsManagementRepository
        
    func rechargeCard(id: String,newAmount: String) async throws {
      try await repo.updateCardAmount(id: id, newAmount: newAmount)
    }
    
}
