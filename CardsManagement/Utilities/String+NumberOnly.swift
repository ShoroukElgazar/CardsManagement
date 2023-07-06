//
//  String+NumberOnly.swift
//  CardsManagement
//
//  Created by Mac on 06/07/2023.
//

import Foundation

extension String {
    
func extractNumericCharacters() -> String {
        return self.components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
}
