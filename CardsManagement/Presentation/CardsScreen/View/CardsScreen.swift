//
//  CardsScreen.swift
//  CardsManagement
//
//  Created by Mac on 01/07/2023.
//

import SwiftUI
import RealmSwift

struct CardsScreen: AppScreen {
    @State var isLoading: Bool = true
    @Inject private var vm : CardsViewModel
    @State private var showAmountAlert = false
    @State private var showErrorAlert = false
    @State private var showDeleteConfirmationDialog = false
    @State private var amount = "0"
    @State private var cardType : CardType = .Unknown
    @State private var selectedCardID = ""
    @State private var cards: [Card] = []
    @EnvironmentObject var networkMonitor: NetworkMonitor

 
    var bodyContent: some View {
        if networkMonitor.isNetworkAvailable {
            NavigationView {
                ZStack{
                    if !cards.isEmpty {
                        CardsView()
                    }else{
                        if !isLoading{
                            Text("No Cards Exist")
                        }else{
                            EmptyView()
                        }
                    }
                }.disabled(isLoading)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: AddCardScreen {
                                Task{
                                    await vm.loadCards()
                                    cards = vm.cards
                            }
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 25, weight: .bold, design: .default))
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                       Text("Cards")
                            .font(.system(size: 25, weight: .bold, design: .default))
                            .foregroundColor(Color("appColor"))
                        
                    }

                }
            }.accentColor(Color("appColor"))
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline:  .now() + 1) {
                    Task{
                        isLoading = true
                        await vm.loadCards()
                        cards = vm.cards
                        isLoading = false
                    }
                }
            }
        } else {
            Text("Network connection seems to be offline.")
        }
    }
    
    private func CardsView() -> some View {
        VStack{
            CardsList()
        }
        .textFieldAlert(isPresented:  $showAmountAlert, title: "Recharge Your Card", text: $amount, placeholder: "", action: { amount in
            handleCardRecharging(amount: amount)
        })
        .showAlert(showingAlert: $showErrorAlert, alertTitle: "", message: vm.error)
        .confirmationDialog("Confirm Delete", isPresented: $showDeleteConfirmationDialog) {
            Button("Delete") {
                Task{
                    isLoading = true
                    await vm.deleteCard(id: selectedCardID)
                   cards = vm.cards
                    isLoading = false
                }
            }
        } message: {
            Text("Are you sure you want to delete this card?")
        }
    }
    
    private func CardsList() -> some View {
        List(cards){ card in
            CreditCardView(card: card) {
                amount = "0"
                showAmountAlert = true
                self.selectedCardID = card.id
            } onDelete: {
                showDeleteConfirmationDialog =  true
                selectedCardID = card.id
            }
        }.listRowSeparator(.hidden)
            .background(Color.clear)
            .listStyle(.plain)
            .listRowBackground(Color.clear)
        
    }
    

    private func handleCardRecharging(amount: String) {
        Task{
            isLoading = true
            await vm.rechargeCard(id: selectedCardID, newAmount: amount)
            cards = vm.cards
            isLoading = false
        }
    
    }

}


