//
//  ImageTextRecognizable+Handling.swift
//  CardsManagement
//
//  Created by Mac on 07/07/2023.
//

import SwiftUI
import VisionKit
import Vision

public protocol ImageTextRecognizable: VNDocumentCameraViewControllerDelegate { }

public extension ImageTextRecognizable {
    
    internal func validateImage(image: UIImage?, completion: @escaping (Card?) -> Void) {
        guard let cgImage = image?.cgImage else { return completion(nil) }
        
        var recognizedText = [String]()
        let textRecognitionRequest = setupTextRecognitionRequest { recognizedTextResult in
               recognizedText = recognizedTextResult
           }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try handler.perform([textRecognitionRequest])
            completion(parseResults(for: recognizedText))
        } catch {
            print(error)
        }
    }
    
    internal func setupTextRecognitionRequest(completion: @escaping ([String]) -> Void) -> VNRecognizeTextRequest {
        let textRecognitionRequest = VNRecognizeTextRequest() { (request, error) in
            guard let results = request.results,
                  !results.isEmpty,
                  let requestResults = request.results as? [VNRecognizedTextObservation]
            else {
                completion([])
                return
            }
            let recognizedText = requestResults.compactMap { observation in
                return observation.topCandidates(1).first?.string
            }
            completion(recognizedText)
        }
        return textRecognitionRequest
    }
    
    
    private func setupTextRecognizer() -> VNRecognizeTextRequest {
        let textRecognitionRequest = VNRecognizeTextRequest()
        textRecognitionRequest.recognitionLevel = .accurate
        textRecognitionRequest.usesLanguageCorrection = false
        textRecognitionRequest.customWords = CardType.allCards.map { $0.rawValue } + ["Expiry Date"]
        return textRecognitionRequest
    }
    
    internal func extractCreditCardNumber(from recognizedText: [String]) -> String? {
        let creditCardNumber = recognizedText.first(where: { $0.count >= 14 && ["4", "5", "3", "6"].contains($0.first) })
        return creditCardNumber
    }

    internal func extractExpiryDate(from recognizedText: [String]) -> String? {
        let expiryDateString = recognizedText.first(where: { $0.count >= 4 && $0.contains("/") })
        var expiryDate = expiryDateString?.filter({ $0.isNumber || $0 == "/" })
        
        if let date = expiryDate {
            if date.count > 5 {
                if let index = date.firstIndex(of: "/") {
                    expiryDate = String(date[..<index]) + date.suffix(from: date.index(index, offsetBy: 3))
                }
            }
        }
        
        return expiryDate
    }

    internal func extractCardHolderName(from recognizedText: [String]) -> String {
        let ignoreList = ["GOOD THRU", "GOOD", "THRU", "Gold", "GOLD", "Standard", "STANDARD", "Platinum", "PLATINUM", "WORLD ELITE", "WORLD", "ELITE", "World Elite", "World", "Elite","neaPay"]
        let wordsToAvoid = ignoreList + CardType.allCards.map { $0.rawValue.lowercased() } + CardType.allCards.map { $0.rawValue.uppercased() }
        let filteredText = recognizedText.filter({ !wordsToAvoid.contains($0) })
        let cardHolderName = filteredText.last ?? ""
        return cardHolderName
    }

    internal func parseResults(for recognizedText: [String]) -> Card {
        let creditCardNumber = extractCreditCardNumber(from: recognizedText)
        let expiryDate = extractExpiryDate(from: recognizedText)
        let cardHolderName = extractCardHolderName(from: recognizedText)
        
        return Card(cardHolder: cardHolderName, cardNumber: creditCardNumber ?? "", expiryDate: expiryDate ?? "")
    }
}
