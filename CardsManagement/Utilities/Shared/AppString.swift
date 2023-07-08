//
//  AppString.swift
//  CardsManagement
//
//  Created by Mac on 05/07/2023.
//

import Foundation

struct AppString {
    
    struct Error {
        public static let emptyData = "There is no available data"
        public static let connection = "Connection is lost, please try again."
        public static let general = "Something went wrong."
        public static let authentication = "Please log in to continue"
        public static let noAvailableData = "no avaialable data"
    }
    
    struct Alert {
        public static let ok = "OK"
        public static let error = "Error"
    }
    
    struct CardsScreen {
           public static let noCardsExist = "No Cards Exist"
           public static let cardsTitle = "Cards"
           public static let rechargeCardTitle = "Recharge Your Card"
           public static let confirmDeleteTitle = "Confirm Delete"
           public static let deleteButtonTitle = "Delete"
           public static let deleteConfirmationMessage = "Are you sure you want to delete this card?"
       }
    struct AddCardScreen {
          public static let cardHolderTitle = "Card Holder"
          public static let cardNumberTitle = "Card Number"
          public static let cvvTitle = "CVV"
          public static let expiryDateTitle = "Expiry Date"
          public static let addCardButtonTitle = "Add Card"
          public static let scanButtonTitle = "scan"
      }
    
    struct CreditCardView {
           public static let cardNumberTitle = "Card Number:"
           public static let expirationDateTitle = "Expiration Date:"
           public static let amountTitle = "Amount:"
           public static let rechargeButtonTitle = "Recharge"
           public static let deleteButtonTitle = "Delete"
       }
    
    struct Colors {
        public static let appColor = "appColor"
        public static let appRed = "appRed"
    }
}
