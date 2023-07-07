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
            return CardsManagementLocalDataSrc()
        }.inObjectScope(.container)
        
        container.register(DefaultCardsManagementRepository.self) { _  in
            return CardsManagementRepo(localDataSrc: CardsManagementLocalDataSrc(), remoteDataSrc: CardsManagementRemoteDataSrc())
        }.inObjectScope(.container)
        
        container.register(DefaultCardsListUseCase.self) { _  in
            return CardsListUseCase(repo: CardsManagementRepo(localDataSrc: CardsManagementLocalDataSrc(), remoteDataSrc: CardsManagementRemoteDataSrc()))
        }.inObjectScope(.container)
        
        container.register(DefaultAddCardUseCase.self) { _  in
            return AddCardUseCase(repo: CardsManagementRepo(localDataSrc: CardsManagementLocalDataSrc(), remoteDataSrc: CardsManagementRemoteDataSrc()))
        }.inObjectScope(.container)
        
        container.register(DefaultDeleteCardUseCase.self) { _  in
            return DeleteCardUseCase(repo: CardsManagementRepo(localDataSrc: CardsManagementLocalDataSrc(), remoteDataSrc: CardsManagementRemoteDataSrc()))
        }.inObjectScope(.container)
        
        container.register(DefaultRechargeCardUseCase.self) { _  in
            return RechargeCardUseCase(repo: CardsManagementRepo(localDataSrc: CardsManagementLocalDataSrc(), remoteDataSrc: CardsManagementRemoteDataSrc()))
        }.inObjectScope(.container)
        
        
        container.register(CardsViewModel.self) { _  in
            return CardsViewModel(cardsListUseCase: CardsListUseCase(repo: CardsManagementRepo(localDataSrc: CardsManagementLocalDataSrc(), remoteDataSrc: CardsManagementRemoteDataSrc())), rechargeCardUseCase: RechargeCardUseCase(repo: CardsManagementRepo(localDataSrc: CardsManagementLocalDataSrc(), remoteDataSrc: CardsManagementRemoteDataSrc())), deleteCardUseCase: DeleteCardUseCase(repo: CardsManagementRepo(localDataSrc: CardsManagementLocalDataSrc(), remoteDataSrc: CardsManagementRemoteDataSrc())), addCardUseCase: AddCardUseCase(repo: CardsManagementRepo(localDataSrc: CardsManagementLocalDataSrc(), remoteDataSrc: CardsManagementRemoteDataSrc())))
        }.inObjectScope(.container)
        
        container.register(Storage.self) { _  in
            return Storage.sharedInstance()
   
        }.inObjectScope(.container)
        return container
    }
}

