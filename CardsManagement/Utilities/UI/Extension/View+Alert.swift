//
//  View+Alert.swift
//  CardsManagement
//
//  Created by Mac on 06/07/2023.
//

import SwiftUI

extension View {
    public func textFieldAlert(
        isPresented: Binding<Bool>,
        title: String,
        text: Binding<String>,
        placeholder: String = "",
        action: @escaping (String) -> Void
    ) -> some View {
        self.modifier(TextFieldAlert(isPresented: isPresented, title: title, text: text, placeholder: placeholder, action: action))
    }
}

extension View {
    func showAlert(showingAlert: Binding<Bool>, alertTitle: String, message: String, buttonTitle: String = "OK") -> some View {
        return alert(alertTitle, isPresented: showingAlert) {
            Button(buttonTitle) {
            }
        } message: {
            Text(message)
        }

    }
}

