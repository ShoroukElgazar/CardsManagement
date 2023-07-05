//
//  AddCardScreen.swift
//  CardsManagement
//
//  Created by Mac on 05/07/2023.
//

import SwiftUI

struct AddCardScreen: View {
    
    @State var vm: AddCardViewModel
    @State var card: Card = Card()
    @State var cardHolderName = ""
    @State var cardHolderNumber = ""
    @State var cardCvv = ""
    @State var cardExpiryDate = ""
    @State var error = ""
    
    var body: some View {
        VStack(spacing: 20){
            TextField("Card Holder Name", text: $cardHolderName).withBorder()
            TextField("Card Holder Number", text: $cardHolderNumber).withBorder()
            TextField("CVV", text: $cardCvv).withBorder()
            TextField("Expiry Date", text: $cardExpiryDate).withBorder()
            Text(error)
                .foregroundColor(.red)

            Button {
                vm.addCard(card: Card(cardHolder: cardHolderName,cardNumber: cardHolderNumber,cvv: cardCvv,expiryDate: cardExpiryDate))
                error = vm.error
            } label: {
                Text("Add Card")
                        .frame(maxWidth: .infinity, minHeight: 52)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
            }
                
                
            Spacer()
        }.padding()
    }
}

extension TextField {
    func withBorder() -> some View {
        self
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
    }
}
