//
//  CreditCardView.swift
//  CardsManagement
//
//  Created by Mac on 08/07/2023.
//

import SwiftUI

struct CreditCardView: View{
     var card: Card
    var onRecharge: () -> Void
    var onDelete: () -> Void
    
    var body: some View {
        VStack{
            Card(card: card)
        }
    }
    private func Card(card: Card) -> some View {
            VStack(alignment: .leading){
                HStack{
                    Text(card.cardHolder)
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .foregroundColor(.red)
                    Spacer()
                    Image(card.cardType.loadIcon())
                }
                VStack(alignment: .leading){
                    Text(AppString.CreditCardView.cardNumberTitle)
                        .foregroundColor(Color(AppString.Colors.appColor))
                        Text(card.cardNumber)
                            .cardFont()

                }
                VStack(alignment: .leading){
                    Text(AppString.CreditCardView.expirationDateTitle)
                        .foregroundColor(Color(AppString.Colors.appColor))
                    Text(card.expiryDate)
                        .cardFont()
                }
                VStack(alignment: .leading){
                    Text(AppString.CreditCardView.amountTitle)
                        .foregroundColor(Color(AppString.Colors.appColor))
                    HStack{
                    Text(card.amount)
                        .cardFont()
                        Spacer()
                        Button {
                            onRecharge()
                        } label: {
                            Text(AppString.CreditCardView.rechargeButtonTitle)
                                .font(.system(size: 18, weight: .bold, design: .default))
                                .foregroundColor(Color(AppString.Colors.appColor))
                                .withBorder()
                        }
                }
              
            }
          
            
        }.padding()
            .background(Color(AppString.Colors.appColor).opacity(0.2))
            .cardView()
            .cornerRadius(5)
            .shadow(radius: 3)
            .swipeActions(allowsFullSwipe: false) {
                DeleteCard(id: card.id)
            }
    }
    
    private func DeleteCard(id: String) -> some View {
        Group{
            Button {
                onDelete()
            } label: {
                Label(AppString.CreditCardView.deleteButtonTitle, systemImage: "trash.fill")
            }
        }
    }
}
