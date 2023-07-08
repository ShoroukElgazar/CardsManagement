//
//  AddCardScreen.swift
//  CardsManagement
//
//  Created by Mac on 05/07/2023.
//

import SwiftUI
import Combine

struct AddCardScreen: AppScreen {
    @Inject private var vm : AddCardViewModel
    @State var isLoading: Bool = false
    @State private var card: Card = Card()
    @State private var cardHolderName = ""
    @State private var cardHolderNumber = ""
    @State private var cardCvv = ""
    @State private var cardExpiryDate = ""
    @State private var error = ""
    @State private var cardType : CardType =  .Unknown
    @Environment(\.presentationMode) var presentationMode
    var onDismiss: () -> Void
    @EnvironmentObject var networkMonitor: NetworkMonitor

    
    var bodyContent: some View {
        if networkMonitor.isNetworkAvailable {
            VStack(spacing: 20){
                
                EntryField(title: "Card Holder Name", placeHoler: "Your Name", text: $cardHolderName)
                
                CardHolderNumberField()
                
                EntryField(title: "CVV", placeHoler: "cvv", text: $cardCvv)
                    .keyboardType(.numberPad)
                
                ExpiryDateField()
                
                Text(error)
                    .foregroundColor(.red)
                
                Spacer().frame(maxHeight: .infinity)
                
                AddCardButton()
                   
            }
            .padding(.top,100)
            .padding(.bottom,20)
             .padding()
             .onTapGesture {
                 self.hideKeyboard()
             }
            

        } else {
            Text("Network connection seems to be offline.")
        }
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
                .keyboardType(.numberPad)
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
            Task{
                do{
                    try await vm.addCard(card: Card(cardHolder: cardHolderName,cardNumber: cardHolderNumber.extractNumericCharacters()
                                              ,cvv: cardCvv,expiryDate: cardExpiryDate,cardType: cardType))
                    DispatchQueue.main.async {
                        isLoading = false
                        onDismiss()
                        presentationMode.wrappedValue.dismiss()
                    }
                } catch {
                    self.error = error.localizedDescription
                }
            }
        } label: {
            Text("Add Card")
                .frame(maxWidth: .infinity, minHeight: 52)
                .background(Color("appColor"))
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
                    .keyboardType(.numberPad)
                    .onChange(of: cardHolderNumber) { newValue in
                        cardType = vm.creditCardValidationType.getCardType(cardNumber: cardHolderNumber.extractNumericCharacters())
                    }
                VStack{
                    Image(cardType.loadIcon())
                   
                    NavigationLink {
                        CardReaderView { card in
                            cardHolderName = card?.cardHolder ?? ""
                            cardHolderNumber = card?.cardNumber ?? ""
                            cardExpiryDate = card?.expiryDate ?? ""
                        }
                    } label: {
                        Text("scan")
                            .foregroundColor(Color("appColor"))
                    }

                   
                }
            }
        }
    }
}



