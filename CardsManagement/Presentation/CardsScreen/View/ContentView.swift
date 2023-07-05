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
   
                }
        }
    }
    
    private func CardsView() -> some View {
        VStack{
            Text("No cards yet")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image(systemName: "plus")
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .onTapGesture {
                                print("add")
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
