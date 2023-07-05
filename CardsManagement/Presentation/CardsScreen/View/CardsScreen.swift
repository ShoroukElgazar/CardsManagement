//
//  CardsScreen.swift
//  CardsManagement
//
//  Created by Mac on 01/07/2023.
//

import SwiftUI

struct CardsScreen: View {
    var body: some View {
        NavigationView {
            ZStack
            {
                CardsView()
                
            }.onAppear{
                do{
                   print(try Storage.sharedInstance().getAllCards() ) 
                }catch{
                    print(error)

                }
            }
        }
    }
    
    private func CardsView() -> some View {
        VStack{
            Text("No cards yet")
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
    
}

struct CardsScreen_Previews: PreviewProvider {
    static var previews: some View {
        CardsScreen()
    }
}
