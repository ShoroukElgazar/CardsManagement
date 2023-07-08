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
            .font(.system(size: 18))
            .fontWeight(.semibold)
            .foregroundColor(Color("appRed"))
            
    }
}
