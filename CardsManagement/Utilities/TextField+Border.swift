//
//  TextField+Border.swift
//  CardsManagement
//
//  Created by Mac on 06/07/2023.
//

import SwiftUI

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
