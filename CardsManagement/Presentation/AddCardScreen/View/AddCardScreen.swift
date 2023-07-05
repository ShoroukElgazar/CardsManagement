//
//  AddCardScreen.swift
//  CardsManagement
//
//  Created by Mac on 05/07/2023.
//

import SwiftUI

struct AddCardScreen: View {
    
    var vm: AddCardViewModel
    @State var card: Card = Card()
    @State var cardHolderName = ""
    @State var cardHolderNumber = ""
    @State var cardCvv = ""
    @State var cardExpiryDate = ""
    
    var body: some View {
        VStack{
            TextField("Card Holder Name", text: $cardHolderName)
            TextField("Card Holder Number", text: $cardHolderNumber)
            TextField("CVV", text: $cardCvv)
            TextField("Expiry Date", text: $cardExpiryDate)
            Button("Add Card") {
                vm.addCard(card: Card(cardHolder: cardHolderName,cardNumber: cardHolderNumber,cvv: cardCvv,expiryDate: cardExpiryDate))
            }
        }
    }
}


