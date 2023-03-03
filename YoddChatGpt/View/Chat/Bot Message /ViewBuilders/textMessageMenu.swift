//
//  textMessageMenu.swift
//  YoddChatGpt
//
//  Created by Ale on 03/03/23.
//

import SwiftUI
import UniformTypeIdentifiers

@ViewBuilder
func textMessageMenu (message: Message) -> some View {
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
}
