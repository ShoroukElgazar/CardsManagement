//
//  TextFieldAlert.swift
//  CardsManagement
//
//  Created by Mac on 06/07/2023.
//

import SwiftUI

struct TextFieldAlert: ViewModifier {
    @Binding var isPresented: Bool
    let title: String
    @Binding var text: String
    let placeholder: String
    let action: (String) -> Void
    var enteredNumberFormatted: Double {
        return (Double(text) ?? 0) / 100
    }
    
    func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            content
                .disabled(isPresented)
            if isPresented {
                VStack {
                    Text(title).font(.headline).padding()
                    ZStack(alignment: .center) {
                        TextField(placeholder, text: $text)
                            .foregroundColor(.clear)
                            .keyboardType(.numberPad)
                            .disableAutocorrection(true)
                            .accentColor(.clear)
                        
                        Text("\(enteredNumberFormatted, specifier: "%.2f")")
                    }
                    Divider()
                    HStack{
                        Spacer()
                        Button(role: .cancel) {
                            withAnimation {
                                isPresented.toggle()
                            }
                        } label: {
                            Text("Cancel")
                        }
                        Spacer()
                        Divider()
                        Spacer()
                        Button() {
                            action(String(enteredNumberFormatted))

                            withAnimation {
                                isPresented.toggle()
                            }
                        } label: {
                            Text("Done")
                        }
                        Spacer()
                    }
                }
                .background(.background)
                .frame(width: 300, height: 150)
                .cornerRadius(20)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.quaternary, lineWidth: 1)
                }
            }
        }
    }
    
   
}

