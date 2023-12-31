//
//  Text+CardFont.swift
//  CardsManagement
//
//  Created by Mac on 08/07/2023.
//

import SwiftUI

extension Text{
    func cardFont() -> some View {
        self
            .font(.system(size: 18, weight: .semibold, design: .default))
            .foregroundColor(Color(AppString.Colors.appRed))            
    }
    func cardtitle() -> some View {
        self
            .font(.system(size: 18, weight: .regular, design: .default))
            .foregroundColor(Color(AppString.Colors.appColor))
    }
}
