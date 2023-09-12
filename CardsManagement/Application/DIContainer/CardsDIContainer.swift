//
//  CardsDIContainer.swift
//  CardsManagement
//
//  Created by Mac on 07/07/2023.
//

import Foundation
import Swinject

class CardsDIContainer {
    
    static let shared: CardsDIContainer = .init()
    
    func buildContainer() -> Container {
        let container = Container()
       
        
        container.register(DefaultCardsManagementDataSrc.self) { _  in
            return CardsManagementRemoteDataSrc()
        }.inObjectScope(.container)

        container.register(DefaultCardsManagementRepository.self) { _  in
            return CardsManagementRepo(localDataSrc: CardsManagementLocalDataSrc())
        }.inObjectScope(.container)
        
        container.register(DefaultCardsListUseCase.self) { _  in
            return CardsListUseCase()
        }.inObjectScope(.container)
        
        container.register(DefaultAddCardUseCase.self) { _  in
            return AddCardUseCase()
        }.inObjectScope(.container)
        
        container.register(DefaultDeleteCardUseCase.self) { _  in
            return DeleteCardUseCase()
        }.inObjectScope(.container)
        
        container.register(DefaultRechargeCardUseCase.self) { _  in
            return RechargeCardUseCase()
        }.inObjectScope(.container)
        
        container.register(AddCardViewModel.self) { _  in
            return AddCardViewModel()
           }.inObjectScope(.container)
           
        
        container.register(CardsViewModel.self) { _  in
            return CardsViewModel()
        }.inObjectScope(.container)
        
        container.register(Storage.self) { _  in
            return Storage()
   
        }.inObjectScope(.container)
        return container
    }
}

