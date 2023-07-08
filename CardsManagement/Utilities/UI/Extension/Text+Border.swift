//
//  Text+Border.swift
//  CardsManagement
//
//  Created by Mac on 08/07/2023.
//

import SwiftUI

extension Text {
    func withBorder() -> some View {
        self
            .padding(5)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(AppString.Colors.appColor), lineWidth: 1)
            )
    }
}
