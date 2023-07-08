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
            ZStack {
                       Color.white.opacity(0.0000001)
                VStack(spacing: 20){
                    
                    EntryField(title: AppString.AddCardScreen.cardHolderTitle, placeHoler: AppString.AddCardScreen.cardHolderTitle.lowercased(), text: $cardHolderName)
                    
                    CardNumberField()
                    
                    EntryField(title: AppString.AddCardScreen.cvvTitle, placeHoler: AppString.AddCardScreen.cvvTitle.lowercased(), text: $cardCvv)
                        .keyboardType(.numberPad)
                    
                    ExpiryDateField()
                    
                    Text(error)
                        .foregroundColor(.red)
 
                }
                .padding()
            }
            .safeAreaInset(edge: VerticalEdge.bottom) {
                AddCardButton()
                    .padding(.bottom,40)
            }
            .disabled(isLoading)
            
             .onTapGesture {
                 self.hideKeyboard()
             }
            

        } else {
            Text(AppString.Error.connection)
                .cardtitle()

        }
    }
    
    private func EntryField(title: String,placeHoler: String,text: Binding<String>) -> some View {
        VStack(alignment: .leading){
            Text(title)
                .cardtitle()
            TextField(placeHoler, text: text).withBorder()
        }
    }
    
    private func ExpiryDateField() -> some View {
        VStack(alignment: .leading){
            Text(AppString.AddCardScreen.expiryDateTitle)
                .cardtitle()
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
            addCard()
        } label: {
            Text(AppString.AddCardScreen.addCardButtonTitle)
                .font(.system(size: 18, weight: .bold))
                .frame(maxWidth: .infinity, minHeight: 52)
                .background(Color(AppString.Colors.appColor))
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.leading, 20)
                .padding(.trailing, 20)
        }
    }
    
    private func addCard() {
        Task{
            do{
                isLoading = true
                try await vm.addCard(card: Card(cardHolder: cardHolderName,cardNumber: cardHolderNumber.extractNumericCharacters()
                                          ,cvv: cardCvv,expiryDate: cardExpiryDate,cardType: cardType))
                DispatchQueue.main.async {
                    isLoading = false
                    onDismiss()
                    presentationMode.wrappedValue.dismiss()
                }
            } catch {
                self.error = error.localizedDescription
                isLoading = false
            }
        }
    }
    
    private func CardNumberField() -> some View {
        VStack(alignment: .leading){
            Text(AppString.AddCardScreen.cardNumberTitle)
                .cardtitle()
            HStack{
                TextField(AppString.AddCardScreen.cardNumberTitle.lowercased(), text: $cardHolderNumber)
                    .withBorder()
                    .keyboardType(.numberPad)
                    .onChange(of: cardHolderNumber) { newValue in
                        cardType = vm.creditCardValidationType.getCardType(cardNumber: cardHolderNumber.extractNumericCharacters())
                    }
                VStack{
                    Image(cardType.loadIcon())
                        .frame(width: 20,height: 20)
                        .padding(.bottom,2)
                    NavigationLink {
                        CardReaderView { card in
                            cardHolderName = card?.cardHolder ?? ""
                            cardHolderNumber = card?.cardNumber ?? ""
                            cardExpiryDate = card?.expiryDate ?? ""
                        }.navigationBarBackButtonHidden()
                     
                    } label: {
                        Text(AppString.AddCardScreen.scanButtonTitle)
                            .withBorder()
                            .foregroundColor(Color(AppString.Colors.appColor))
                    }

                   
                }
            }
        }
    }
    
}

