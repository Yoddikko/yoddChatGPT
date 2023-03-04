//
//  createMessageBubble.swift
//  YoddChatGpt
//
//  Created by Ale on 03/03/23.
//

import SwiftUI

@ViewBuilder
func createMessageBubble(messageType: MessageType, messageBody: String, messageData: Data) -> some View {
    switch messageType {
    case .text:
        Text(messageBody)
            .multilineTextAlignment(.leading)
    case .error:
        Text(messageBody)
            .foregroundColor(.red)
    case .image:
        if messageData != nil {
            createImageMessageBubble(messageData: messageData)
        }
    }
}

@ViewBuilder
func createImageMessageBubble(messageData: Data) -> some View {
    Image(uiImage: UIImage(data: messageData)!)
        .resizable()
        .cornerRadius(15, corners: [.topLeft, .topRight, .bottomRight])
        .scaledToFit()
    

}
