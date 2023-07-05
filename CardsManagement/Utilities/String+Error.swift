//
//  String+Error.swift
//  CardsManagement
//
//  Created by Mac on 06/07/2023.
//

import Foundation

extension String: Error {}

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
