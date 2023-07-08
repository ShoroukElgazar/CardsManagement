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
                    Text(title).font(.headline)
                        .foregroundColor(Color("appColor"))
                        .padding(.top,3)
                    ZStack(alignment: .leading) {
                        TextField(placeholder, text: $text)
                            .foregroundColor(.clear)
                            .keyboardType(.numberPad)
                            .disableAutocorrection(true)
                            .accentColor(.clear)
                        
                        Text("\(enteredNumberFormatted, specifier: "%.2f")")
                            .padding(.leading)
                
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
                .frame(width: 300, height: 160)
                .cornerRadius(20)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.quaternary, lineWidth: 1)
                }
            }
        }
    }
    
   
}

