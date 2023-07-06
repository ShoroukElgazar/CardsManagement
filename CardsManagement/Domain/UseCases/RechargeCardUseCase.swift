//
//  RechargeCardUseCase.swift
//  CardsManagement
//
//  Created by Mac on 06/07/2023.
//

import Foundation

class RechargeCardUseCase: DefaultRechargeCardUseCase {
    private var repo : DefaultCardsManagementRepository
    
    init(repo: DefaultCardsManagementRepository) {
        self.repo = repo
    }
    
    func rechargeCard(id: String,newAmount: String) throws {
      try  repo.updateCardAmount(id: id, newAmount: newAmount)
    }
    
}
