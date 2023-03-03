//
//  createMessageBubble.swift
//  YoddChatGpt
//
//  Created by Ale on 03/03/23.
//

import SwiftUI

@ViewBuilder
func createMessageBubble(messageType: MessageType, messageBody: String) -> some View {
    switch messageType {
    case .text:
        Text(messageBody)
            .multilineTextAlignment(.leading)
    case .error:
        Text(messageBody)
            .foregroundColor(.red)
    case .image:
        AsyncImage(url: URL(string: messageBody)) { image in
            image.resizable()
                .cornerRadius(15, corners: [.topLeft, .topRight, .bottomRight])
                .scaledToFit()
        } placeholder: {
            Rectangle().scaledToFit()
        }
    }
}
