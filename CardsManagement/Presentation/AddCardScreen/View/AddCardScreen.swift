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
    
    var body: some View {
        VStack(spacing: 20){
            
            EntryField(title: "Card Holder Name", placeHoler: "Your Name", text: $cardHolderName)
            
            EntryField(title: "Card Holder Number", placeHoler: "card number", text: $cardHolderNumber)
            
            EntryField(title: "CVV", placeHoler: "cvv", text: $cardCvv)
         
            ExpiryDateField()
    

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
                .onChange(of: cardExpiryDate) { newValue
                    in
                    print(newValue.count)
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
}



