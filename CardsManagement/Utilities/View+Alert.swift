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
    func errorAlert(showingErrorAlert: Binding<Bool>,errorReason: String, buttonTitle: String = "OK") -> some View {
        return alert("Error", isPresented: showingErrorAlert) {
            Button(buttonTitle) {
            }
        } message: {
            Text(errorReason)
        }

    }
}


