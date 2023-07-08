//
//  View+Keyboard.swift
//  CardsManagement
//
//  Created by Mac on 08/07/2023.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
