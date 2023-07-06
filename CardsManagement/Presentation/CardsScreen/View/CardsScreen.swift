//
//  CardsScreen.swift
//  CardsManagement
//
//  Created by Mac on 01/07/2023.
//

import SwiftUI

struct CardsScreen: View {
    @State var vm: CardsViewModel
    var body: some View {
        NavigationView {
            ZStack
            {
                CardsView()
                
            }.onAppear{
                print("cardslist:",vm.cards)

               
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
       }
    private func CardsList() -> some View {
      
        List(vm.cards){ card in
            HStack{
                Text(card.cardHolder)
                Spacer()
                Button {
                } label: {
                    Text("Recharge")
                }

            }
            
        }
        
    }
}


