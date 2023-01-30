//
//  EmptyChatView.swift
//  YoddChatGpt
//
//  Created by Ale on 27/01/23.
//

import SwiftUI
/**
 This is the view that is shown when there's no message in the chat.

 - Version: 0.1

 */
struct EmptyChatView: View {
    var body: some View {
        Spacer()
        Text("🤖 Bip bop ask me anything").foregroundColor(.secondary)
        Spacer()
    }
}

struct EmptyChatView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyChatView()
    }
}
