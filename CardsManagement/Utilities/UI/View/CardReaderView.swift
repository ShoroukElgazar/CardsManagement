//
//  CardReaderView.swift
//  CardsManagement
//
//  Created by Mac on 06/07/2023.
//

import Vision
import VisionKit
import SwiftUI

struct CardReaderView: UIViewControllerRepresentable {
    
    private let completionHandler: (Card?) -> Void
    @Environment(\.presentationMode) var presentationMode

     typealias UIViewControllerType = VNDocumentCameraViewController
    
    init(completionHandler: @escaping (Card?) -> Void) {
       self.completionHandler = completionHandler
    }
    public func makeCoordinator() -> Coordinator {
        Coordinator(self, completionHandler: completionHandler)
    }
    
    
    final public class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate, ImageTextRecognizable {
       private let completionHandler: (Card?) -> Void
        var parent: CardReaderView

    
       init(_ parent: CardReaderView,completionHandler: @escaping (Card?) -> Void) {
           self.parent = parent
          self.completionHandler = completionHandler
       }
        
       public func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
           
          let image = scan.imageOfPage(at: 0)
          validateImage(image: image) { card in
             self.completionHandler(card)
          }
             parent.presentationMode.wrappedValue.dismiss()
       }
        
       public func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
          completionHandler(nil)
           parent.presentationMode.wrappedValue.dismiss()
       }
        
       public func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
          print("Document camera view controller did finish with error ", error)
          completionHandler(nil)
           parent.presentationMode.wrappedValue.dismiss()
       }
        
    }
     func makeUIViewController(context: UIViewControllerRepresentableContext<CardReaderView>) -> VNDocumentCameraViewController {
       let viewController = VNDocumentCameraViewController()
       viewController.delegate = context.coordinator
       return viewController
    }
    
     func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: UIViewControllerRepresentableContext<CardReaderView>) {
       
     }
    
}

