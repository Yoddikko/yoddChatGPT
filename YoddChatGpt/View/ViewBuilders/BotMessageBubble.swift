//
//  CreateBotMessage.swift
//  YoddChatGpt
//
//  Created by Ale on 27/01/23.
//

import SwiftUI
import UniformTypeIdentifiers

// MARK: - ViewModels
var speechSynthesizer = SpeechSynthesizer()

/**
 This is the viewbuilder that creates the bot message bubble.

 - Version: 0.1

 */
@ViewBuilder
func createBotMessageBubble (text : String, type : MessageType) -> some View {
    
    Menu {
        Button(action: {
            UIPasteboard.general.setValue(text,
                forPasteboardType: UTType.plainText.identifier)
        }) {
            Label("Copy", systemImage: "doc.on.doc")
        }

        Button(action: {
            speechSynthesizer.readString(text: text)
        }) {
            Label("Listen", systemImage: "ear")
        }
        
        Button(action: {
            speechSynthesizer.readString(text: text)
        }) {
            Label("Save", systemImage: "bookmark")
        }

        Button(action: {
            
        }) {
            Label("Delete", systemImage: "trash").foregroundColor(.red)
        }
    } label: {
        
        HStack() {
            if type == .text {
                Text(text)
                    .multilineTextAlignment(.leading)
                    .padding(.trailing, 30)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .padding(.leading, 5)
            }
            else if type == .error{
                Text(text)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.leading)
                    .padding(.trailing, 30)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .padding(.leading, 5)
                
            }
        }.background {
            ZStack {
                RoundedRectangle(cornerRadius: 15).foregroundColor(.secondary.opacity(0.1))
                    .padding(.trailing, 30).padding(.leading, 5)
            }
        }
    }    .buttonStyle(.plain)
}
