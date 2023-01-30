//
//  BotMessageBubble.swift
//  YoddChatGpt
//
//  Created by Ale on 29/01/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct BotMessageBubble: View {
    @Environment (\.managedObjectContext) var managedObjectContext
    @StateObject var speechSynthesizer = SpeechSynthesizer.shared
    @ObservedObject var chatColors = ThemeViewModel.shared

    var primaryColor : Color
    var secondaryColor : Color
    var message : Message
    var type : MessageType
    var body: some View {
        Menu {
            Button(action: {
                UIPasteboard.general.setValue(message.body!,
                                              forPasteboardType: UTType.plainText.identifier)
            }) {
                Label("Copy", systemImage: "doc.on.doc")
            }
            
            
            
            Button(action: {
                SpeechSynthesizer.shared.readString(text: message.body!)
            }) {
                Label("Listen", systemImage: "ear")
            }
            
            
            
            
            
            
            Button(action: {
                //                speechSynthesizer.readString(text: message.body!)
            }) {
                Label("Save", systemImage: "bookmark")
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
                if type == .text {
                    Text(message.body!)
                        .multilineTextAlignment(.leading)
                        .padding(.trailing, 30)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 10)
                        .padding(.leading, 5)
                }
                else if type == .error{
                    Text(message.body!)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.leading)
                        .padding(.trailing, 30)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 10)
                        .padding(.leading, 5)
                    
                }
            }.background {
                ZStack {
                    RoundedRectangle(cornerRadius: 15).foregroundColor(secondaryColor)
                        .padding(.trailing, 30).padding(.leading, 5)
                }
            }
        }    .buttonStyle(.plain)
            .onChange(of: SpeechSynthesizer.shared.speechSynthesizer.isSpeaking) { state in
                print(state)
            }
    }
}


//struct BotMessageBubble_Previews: PreviewProvider {
//    static var previews: some View {
//        BotMessageBubble(speechSynthesizer: SpeechSynthesizer(), message: Message(), type: .text)
//    }
//}
