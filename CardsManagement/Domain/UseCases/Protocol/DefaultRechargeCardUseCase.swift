//
//  DefaultRechargeCardUseCase.swift
//  CardsManagement
//
//  Created by Mac on 06/07/2023.
//

import Foundation

protocol DefaultRechargeCardUseCase {
    func rechargeCard(id: String, newAmount: String) async throws 
}
