//
//  Resolver.swift
//  CardsManagement
//
//  Created by Mac on 07/07/2023.
//

import Foundation

@propertyWrapper
struct Inject<I> {
    let wrappedValue: I
    init() {
        self.wrappedValue = Resolver.shared.resolve(I.self)
    }
}

class Resolver {
    static let shared = Resolver()
    
    private var container = CardsDIContainer.shared.buildContainer()
    
    func resolve<T>(_ type: T.Type) -> T {
        container.resolve(T.self)!
    }
}

