/*
The MIT License (MIT)

 Copyright (c) 2023 Alessio Iodice

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

//
//  UserMessageBubble.swift
//  YoddChatGpt
//
//  Created by Ale on 01/02/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct UserMessageBubble: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment (\.managedObjectContext) var managedObjectContext

    var message: Message
    var primaryColor: Color
    var secondaryColor: Color
    
    @State var scale = 0.8
    
    var body: some View {
        Menu {
            Button(action: {
                UIPasteboard.general.setValue(message.body!,
                                              forPasteboardType: UTType.plainText.identifier)
            }) {
                Label("Copy", systemImage: "doc.on.doc")
            }

            Button(role: .destructive, action: {
                DataController.shared.deleteData(context: managedObjectContext, message: message)
            }) {
                HStack {
                    Text("Delete")
                    Spacer()
                    Image(systemName: "trash")
                }
            }
        } label: {

        HStack() {
            Text(message.body!)
                .foregroundColor(colorScheme == .light ? .black : .white)
                .multilineTextAlignment(.leading)
                .padding(.leading, 30)
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .padding(.trailing, 15)
        }.background {
            ZStack {
                Rectangle().foregroundColor(primaryColor)
                    .cornerRadius(20, corners: [.topLeft, .topRight, .bottomLeft])
                    .padding(.leading, 30).padding(.trailing, 15)

            }
        }
        .scaleEffect(scale)
        .onAppear{
            let baseAnimation = Animation.easeIn(duration: 0.2)

            withAnimation(baseAnimation) {
                scale = 1
            }
        }

        }.buttonStyle(.plain)
    }
}

struct UserChatBubble_Previews: PreviewProvider {
    static var previews: some View {
        UserMessageBubble(message: Message(), primaryColor: Color(.blue), secondaryColor: Color(.systemTeal))
    }
}
