//
//  UserMessageBubble.swift
//  YoddChatGpt
//
//  Created by Ale on 27/01/23.
//

import SwiftUI

/**
 This is the viewbuilder that creates the user message bubble.

 - Version: 0.1

 */
@ViewBuilder
func createUserMessageBubble (text : String, primaryColor: Color, secondaryColor: Color) -> some View {
    HStack() {
        Text(text)
            .multilineTextAlignment(.leading)
            .padding(.leading, 30)
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
            .padding(.trailing, 5)
    }.background {
        ZStack {
            RoundedRectangle(cornerRadius: 15).foregroundColor(primaryColor)
                .padding(.leading, 30).padding(.trailing, 5)
        }
    }
}

