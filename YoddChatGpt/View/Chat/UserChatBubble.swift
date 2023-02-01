//
//  UserMessageBubble.swift
//  YoddChatGpt
//
//  Created by Ale on 01/02/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct UserMessageBubble: View {
    @Environment (\.managedObjectContext) var managedObjectContext

    var message : Message
    var primaryColor : Color
    var secondaryColor : Color
    
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
                .multilineTextAlignment(.leading)
                .padding(.leading, 30)
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .padding(.trailing, 5)
        }.background {
            ZStack {
                Rectangle().foregroundColor(primaryColor)
                    .cornerRadius(20, corners: [.topLeft, .topRight, .bottomLeft])
                    .padding(.leading, 30).padding(.trailing, 5)

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
        UserMessageBubble(message:Message(), primaryColor: Color(.blue), secondaryColor: Color(.systemTeal))
    }
}
