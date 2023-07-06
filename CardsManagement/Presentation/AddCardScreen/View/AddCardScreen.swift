//
//  AddCardScreen.swift
//  CardsManagement
//
//  Created by Mac on 05/07/2023.
//

import SwiftUI
import Combine

struct AddCardScreen: View {
    
    @State var vm: AddCardViewModel
    @State var card: Card = Card()
    @State var cardHolderName = ""
    @State var cardHolderNumber = ""
    @State var cardCvv = ""
    @State var cardExpiryDate = ""
    @State var error = ""
    @State var cardType : CardType =  .Unknown
    
    var body: some View {
        VStack(spacing: 20){
            
            EntryField(title: "Card Holder Name", placeHoler: "Your Name", text: $cardHolderName)
            
            CardHolderNumberField()

            EntryField(title: "CVV", placeHoler: "cvv", text: $cardCvv)
            
            ExpiryDateField()
            
            Text(error)
                .foregroundColor(.red)
            
            AddCardButton()
            
            Spacer()
        }.padding()
    }
    
    private func EntryField(title: String,placeHoler: String,text: Binding<String>) -> some View {
        VStack(alignment: .leading){
            Text(title)
            TextField(placeHoler, text: text).withBorder()
        }
    }
    
    private func ExpiryDateField() -> some View {
        VStack(alignment: .leading){
            Text("Expiry Date")
            TextField("MM/YY", text: $cardExpiryDate)
                .withBorder()
                .onChange(of: cardExpiryDate) { newValue in
                    if newValue.count > 2 {
                        let monthIndex = newValue.index(newValue.startIndex, offsetBy: 2)
                        let yearIndex = newValue.index(newValue.startIndex, offsetBy: 2)
                        let month = newValue[..<monthIndex]
                        let year = newValue[yearIndex...].trimmingCharacters(in: CharacterSet(charactersIn: "/"))
                        cardExpiryDate = "\(month)/\(year.prefix(2))"
                    }
                }
        }
    }
    
    private func AddCardButton() -> some View {
        Button {
            vm.addCard(card: Card(cardHolder: cardHolderName,cardNumber: cardHolderNumber.extractNumericCharacters()
                                  ,cvv: cardCvv,expiryDate: cardExpiryDate,cardType: cardType.rawValue))
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
    }
    
    
    private func CardHolderNumberField() -> some View {
        VStack(alignment: .leading){
            Text("Card Holder Number")
            HStack{
                TextField("card number", text: $cardHolderNumber)
                    .withBorder()
                    .onChange(of: cardHolderNumber) { newValue in
                        cardType = vm.creditCardValidationType.getCardType(cardNumber: cardHolderNumber.extractNumericCharacters())
                    }
                Image(cardType.loadIcon())
            }
        }
    }
}



