//
//  CardsScreen.swift
//  CardsManagement
//
//  Created by Mac on 01/07/2023.
//

import SwiftUI
import RealmSwift

struct CardsScreen: View {
    var vm: CardsViewModel
    @ObservedResults(CardDTO.self) var cards
    @State private var showAmountAlert = false
    @State private var showErrorAlert = false
    @State private var amount = "0"
    @State private var selectedCardID = ""
    
    var body: some View {
        NavigationView {
            ZStack
            {
                CardsView()
            }
        }
    }
    
    private func CardsView() -> some View {
        VStack{
            CardsList()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: AddCardScreen(vm: AddCardViewModel(addCardUseCase: AddCardUseCase(repo: CardsManagementRepo(localDataSrc: CardsManagementLocalDataSrc()))))) {
                            Image(systemName: "plus")
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                        }
                    }
                }
        }
        .textFieldAlert(isPresented:  $showAmountAlert, title: "Recharge Your Card", text: $amount, placeholder: "", action: { amount in
          handleCardRecharging(amount: amount)
        })
        .errorAlert(showingErrorAlert: $showErrorAlert, errorReason: vm.error)
       }
    
    private func CardsList() -> some View {
        List(cards){ card in
            HStack{
                VStack(alignment: .leading){
                    Text(card.cardHolder)
                    Text(card.cardNumber)
                    Text(card.expiryDate)
                    Text(card.amount)
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
                .onAppear{
                    print("appeared")
                }
            
        }.listRowSeparator(.hidden)
            .background(Color.clear)
            .listStyle(.plain)
            .listRowBackground(Color.clear)
        
    }
    
    private func handleCardRecharging(amount: String) {
        vm.rechargeCard(id: selectedCardID, newAmount: amount)
        if vm.showValidationError {
            showErrorAlert = true
        }else{
            showErrorAlert = false
        }
    }
}




