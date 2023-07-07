//
//  CardsScreen.swift
//  CardsManagement
//
//  Created by Mac on 01/07/2023.
//

import SwiftUI
import RealmSwift

struct CardsScreen: AppScreen {
    @State var isLoading: Bool = false
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
                ZStack
                {
                    if !cards.isEmpty{
                        CardsView()
                    }else{
                        Text("No Cards Exist")
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: AddCardScreen{ cards in
                            self.cards = cards
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                        }
                    }
                }
            }
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
            Text("offline")
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
            Card(card: card)
        }.listRowSeparator(.hidden)
            .background(Color.clear)
            .listStyle(.plain)
            .listRowBackground(Color.clear)
        
    }
    
    private func Card(card: Card) -> some View {
        HStack{
            VStack(alignment: .leading){
                Text(card.cardHolder)
                Text(card.cardNumber)
                Text(card.expiryDate)
                Text(card.amount)
                Image(card.cardType.loadIcon())
            }
            Spacer()
            Button {
                amount = "0"
                showAmountAlert = true
                self.selectedCardID = card.id
            } label: {
                Text("Recharge")
            }
            
        }.padding()
            .background(Color.indigo.opacity(0.2))
            .cardView()
            .cornerRadius(5)
            .shadow(radius: 3)
            .swipeActions(allowsFullSwipe: false) {
                
                DeleteCard(id: card.id)
            }
    }
    
    private func DeleteCard(id: String) -> some View {
        Group{
            Button {
                showDeleteConfirmationDialog =  true
                selectedCardID = id
            } label: {
                Label("Delete", systemImage: "trash.fill")
            }
        }
    }
    
    private func handleCardRecharging(amount: String) {
        Task{
            isLoading = true
            await vm.rechargeCard(id: selectedCardID, newAmount: amount)
            cards = vm.cards
            isLoading = false
        }
        if vm.showValidationError {
            showErrorAlert = true
        }else{
            showErrorAlert = false
        }
    }

}

