//
//  AppScreen.swift
//  CardsManagement
//
//  Created by Mac on 07/07/2023.
//

import SwiftUI
import Alamofire

public protocol AppScreen: View {
    associatedtype Content: View
    associatedtype Background: View
    var backgroundColor: Background { get }
    var isLoading: Bool { get set }
    func onAppear()
    
    @ViewBuilder var bodyContent: Content { get }

}

public extension AppScreen {
    
    var body: some View {
        ZStack {
            bodyContent
                .onAppear(perform: onAppear)
            if isLoading {
                ProgressView()
                    .padding()
            }
        }
        .background(backgroundColor)
        .ignoresSafeArea(.all)
        
    }
    
    func onAppear() {
    }
    
    var backgroundColor: some View {
        Color.white
    }

}



class NetworkMonitor: ObservableObject {
    @Published var isNetworkAvailable = false
    
    private let reachabilityManager = NetworkReachabilityManager()
    
    init() {
        startMonitoring()
    }
    
    private func startMonitoring() {
        if NetworkReachabilityManager()?.isReachable ?? false {
            isNetworkAvailable = true
        } else {
            isNetworkAvailable = false
        }
    }
}

