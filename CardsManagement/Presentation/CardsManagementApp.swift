//
//  CardsManagementApp.swift
//  CardsManagement
//
//  Created by Mac on 01/07/2023.
//

import SwiftUI

@main
struct CardsManagementApp: App {
    var body: some Scene {
        WindowGroup {
            CardsScreen(vm: CardsViewModel(cardsListUseCase: CardsListUseCase(repo: CardsManagementRepo(localDataSrc: CardsManagementLocalDataSrc())), rechargeCardUseCase: RechargeCardUseCase(repo: CardsManagementRepo(localDataSrc: CardsManagementLocalDataSrc())), deleteCardUseCase: DeleteCardUseCase(repo: CardsManagementRepo(localDataSrc: CardsManagementLocalDataSrc()))))
        }
    }
}
